local QBCore = exports['qb-core']:GetCoreObject()
local wheelStates = {}

function isWheelLoosened(closestVehicle, wheelIndex)
    local vehicleId = NetworkGetNetworkIdFromEntity(closestVehicle)
    return wheelStates[vehicleId] and wheelStates[vehicleId][wheelIndex] == 'loosened'
end

function setWheelState(closestVehicle, wheelIndex, state)
    local vehicleId = NetworkGetNetworkIdFromEntity(closestVehicle)
    if not wheelStates[vehicleId] then
        wheelStates[vehicleId] = {}
    end
    wheelStates[vehicleId][wheelIndex] = state
end

function loosenWheelNuts()
    local closestVehicle = getClosestVehicle()
    if closestVehicle and DoesEntityExist(closestVehicle) then
        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        local wheelIndices = {0, 1, 2, 3}
        local closestWheelIndex = -1
        local closestDistance = 2.0

        for _, wheelIndex in ipairs(wheelIndices) do
            local wheelBoneNames = {"wheel_lf", "wheel_rf", "wheel_lr", "wheel_rr"}
            local wheelBone = wheelBoneNames[wheelIndex + 1]
            local wheelBoneIndex = GetEntityBoneIndexByName(closestVehicle, wheelBone)

            if wheelBoneIndex ~= -1 then
                local wheelCoords = GetWorldPositionOfEntityBone(closestVehicle, wheelBoneIndex)
                local distance = #(wheelCoords - playerCoords)

                if distance < closestDistance then
                    closestDistance = distance
                    closestWheelIndex = wheelIndex
                end
            end
        end

        if closestWheelIndex ~= -1 then
            if isWheelLoosened(closestVehicle, closestWheelIndex) then
                lib.notify({
                    description = Lang['wheel_already_loosened'],
                    type = 'error'
                })
                return
            end

            local skillSuccess = lib.skillCheck(Config.WheelLoosenSkillcheck.difficulty, Config.WheelLoosenSkillcheck.keys)
            if skillSuccess then
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 15.0, 'impactdrill', 1.0)
                if lib.progressCircle({
                    duration = Config.WheelLoosenProgress,
                    position = 'bottom',
                    canCancel = true,
                    disable = {move = true},
                    anim = {
                        dict = 'anim@heists@fleeca_bank@drilling',
                        clip = 'drill_straight_end',                 
                    },
                    prop = {
                        model = `prop_tool_consaw`, 
                        pos = vec3(0.04, 0.06, 0.20), --l/r, foward/back, up
                        rot = vec3(15.0, 0.0, 270.0)
                    },                    
                }) then
                    setWheelState(closestVehicle, closestWheelIndex, 'loosened')
                    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'nut_loosen', 1.0)
                    SetVehicleAlarm(closestVehicle, true)
                    StartVehicleAlarm(closestVehicle)
                    TriggerServerEvent('v-vehiclesab:useSpanner')
                else
                    lib.notify({
                        title = Lang['action_canceled'],
                        description = Lang['loosen_canceled'],
                        type = 'error'
                    })
                end
            else
                lib.notify({
                    title = Lang['skill_check_failed'],
                    description = Lang['failed_to_loosen'],
                    type = 'error'
                })
            end
        else
            lib.notify({
                description = Lang['no_wheel_found'],
                type = 'error'
            })
        end
    else
        lib.notify({
            description = Lang['no_vehicle_found'],
            type = 'error'
        })
    end
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle and DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped then
            local speed = GetEntitySpeed(vehicle) * 2.23694
            local vehicleId = NetworkGetNetworkIdFromEntity(vehicle)

            if wheelStates[vehicleId] then
                for wheelIndex, state in pairs(wheelStates[vehicleId]) do
                    if state == 'loosened' and speed > Config.WheelFallOffSpeed then
                        takeOffLooseWheel(vehicle, tonumber(wheelIndex))
                        setWheelState(vehicle, wheelIndex, 'off')
                    end
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

function loadModel(model)
    RequestModel(model)
    local timeout = 5000
    local startTime = GetGameTimer()

    while not HasModelLoaded(model) do
        Wait(0)
        if GetGameTimer() - startTime > timeout then
            return false
        end
    end

    return true
end

function takeOffLooseWheel(closestVehicle, closestWheelIndex)
    BreakOffVehicleWheel(closestVehicle, closestWheelIndex, true, true, true, false)

    ApplyForceToEntity(closestVehicle, 0, 0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, true, true, true)
    
    lib.notify({
        description = 'A wheel has fallen off due to loosened nuts!',
        type = 'error'
    })

    local wheelPos = GetEntityCoords(closestVehicle)

    local modelName = `prop_stockade_wheel_flat`
    if not loadModel(modelName) then
        print("Model failed to load!") 
        return
    end

    local tireProp = CreateObject(modelName, wheelPos.x, wheelPos.y, wheelPos.z, true, true, true)

    if DoesEntityExist(tireProp) then
        print("Tire prop created successfully!")
    else
        print("Failed to create tire prop!")
        return
    end

    exports.ox_target:addLocalEntity(tireProp, {
        {
            label = Lang.Lang['pickup_tire'],
            distance = 2.0,
            icon = "fa-solid fa-hand",
            onSelect = function()
                DeleteObject(tireProp)

                TriggerServerEvent('v-vehiclesab:giveTire')

                exports.ox_target:removeLocalEntity(tireProp, Lang.Lang['pickup_tire'])
            end
        }
    })
end

exports('useSpanner', function(data)
    loosenWheelNuts()
end)
