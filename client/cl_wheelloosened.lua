local QBCore = exports['qb-core']:GetCoreObject()
local wheelStates = {}
local playerCooldowns = {}

function isWheelLoosened(closestVehicle, wheelIndex)
    local vehicleId = NetworkGetNetworkIdFromEntity(closestVehicle)
    return wheelStates[vehicleId] and wheelStates[vehicleId][wheelIndex] == 'loosened'
end

function setWheelState(closestVehicle, wheelIndex, state)
    local vehicleId = NetworkGetNetworkIdFromEntity(closestVehicle)
    wheelStates[vehicleId] = wheelStates[vehicleId] or {}
    wheelStates[vehicleId][wheelIndex] = state
end

function checkCooldown(src)
    if not src or type(src) ~= "number" then
        print("Warning: Invalid src value. It must be a number.")
        return false
    end

    local currentTime = GetGameTimer()

    if playerCooldowns[src] == nil then
        playerCooldowns[src] = 0
        print("Initialized player cooldown for " .. src .. " to 0.")
    end

    if type(playerCooldowns[src]) ~= "number" then
        playerCooldowns[src] = 0
        print("Resetting player cooldown for " .. src .. " to 0 due to incorrect type.")
    end

    if (currentTime - playerCooldowns[src]) < Config.TireCooldown then
        local timeLeft = math.ceil((Config.TireCooldown - (currentTime - playerCooldowns[src])) / 1000)
        lib.notify({ 
            description = Lang.Lang['must_wait'] .. timeLeft .. Lang.Lang['must_wait_2'], 
            type = 'error' 
        })
        return false
    end

    playerCooldowns[src] = currentTime
    return true
end

local function loosenWheelNuts()
    local src = PlayerId()

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        return lib.notify({ description = Lang['must_be_outside_vehicle'], type = 'error' })
    end

    if not checkCooldown(src) then
        return
    end

    local closestVehicle = getClosestVehicle()
    if not (closestVehicle and DoesEntityExist(closestVehicle)) then
        print("DEBUG: No vehicle found.")
        return lib.notify({ description = Lang['no_vehicle_found'], type = 'error' })
    end

    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    local closestWheelIndex, closestDistance = -1, 2.0
    local wheelBoneNames = {"wheel_lf", "wheel_rf", "wheel_lr", "wheel_rr"}

    for wheelIndex, wheelBone in ipairs(wheelBoneNames) do
        local wheelBoneIndex = GetEntityBoneIndexByName(closestVehicle, wheelBone)
        if wheelBoneIndex ~= -1 then
            local wheelCoords = GetWorldPositionOfEntityBone(closestVehicle, wheelBoneIndex)
            local distance = #(wheelCoords - playerCoords)

            if distance < closestDistance then
                closestDistance = distance
                closestWheelIndex = wheelIndex - 1
            end
        end
    end

    if closestWheelIndex ~= -1 then
        if isWheelLoosened(closestVehicle, closestWheelIndex) then
            print("DEBUG: Wheel already loosened.")
            return lib.notify({ description = Lang['wheel_already_loosened'], type = 'error' })
        end

        local skillSuccess = lib.skillCheck(Config.WheelLoosenSkillcheck.difficulty, Config.WheelLoosenSkillcheck.keys)

        if skillSuccess then
            if lib.progressCircle({
                duration = Config.WheelLoosenProgress,
                position = 'bottom',
                canCancel = true,
                disable = { move = true },
                anim = {
                    dict = 'anim@heists@fleeca_bank@drilling',
                    clip = 'drill_straight_end',
                },
                prop = {
                    model = 'prop_tool_consaw',
                    pos = vec3(0.04, 0.06, 0.20),
                    rot = vec3(15.0, 0.0, 270.0)
                },
            }) then
                setWheelState(closestVehicle, closestWheelIndex, 'loosened')
                SetVehicleAlarm(closestVehicle, true)
                StartVehicleAlarm(closestVehicle)
            else
                lib.notify({ title = Lang['action_canceled'], description = Lang['loosen_canceled'], type = 'error' })
            end
        else
            lib.notify({ title = Lang['skill_check_failed'], description = Lang['failed_to_loosen'], type = 'error' })
        end
    else
        print("DEBUG: No wheel found.")
        lib.notify({ description = Lang['no_wheel_found'], type = 'error' })
    end
end

local function takeOffLooseWheel(closestWheelIndex)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if DoesEntityExist(vehicle) then
        TriggerServerEvent('v-vehiclesab:removeLooseWheel', closestWheelIndex, NetworkGetNetworkIdFromEntity(vehicle))
    else
        print("Vehicle does not exist.")
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle and DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped then
            local speed = GetEntitySpeed(vehicle) * 2.23694
            local vehicleId = NetworkGetNetworkIdFromEntity(vehicle)

            if wheelStates[vehicleId] then
                for wheelIndex, state in pairs(wheelStates[vehicleId]) do
                    if state == 'loosened' then
                        print("DEBUG: Wheel " .. wheelIndex .. " is loosened at speed " .. speed)
                        if speed > Config.WheelFallOffSpeed then
                            takeOffLooseWheel(tonumber(wheelIndex))
                            setWheelState(vehicle, wheelIndex, 'off')
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('v-vehiclesab:breakOffWheelClient')
AddEventHandler('v-vehiclesab:breakOffWheelClient', function(closestWheelIndex, vehicleNetId)
    local closestVehicle = NetToVeh(vehicleNetId)

    if DoesEntityExist(closestVehicle) then
        BreakOffVehicleWheel(closestVehicle, closestWheelIndex, true, true, true, false)
        ApplyForceToEntity(closestVehicle, 2, 0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, true, true, true, true, true)

        local vehiclePos = GetEntityCoords(closestVehicle)
        local wheelOffset = GetWheelOffset(closestVehicle, closestWheelIndex)
        local wheelPos = vector3(vehiclePos.x + wheelOffset.x, vehiclePos.y + wheelOffset.y, vehiclePos.z + wheelOffset.z)

        TriggerServerEvent('v-vehiclesab:createTireProp', wheelPos, closestVehicle)
    else
        print("Attempted to break off a wheel on a non-existent vehicle.")
    end
end)

RegisterNetEvent('v-vehiclesab:tirePropTarget')
AddEventHandler('v-vehiclesab:tirePropTarget', function(netId, closestVehicle, wheelPos)
    local tireProp = NetworkGetEntityFromNetworkId(netId)

    if DoesEntityExist(tireProp) then
        exports.ox_target:addLocalEntity(tireProp, {
            {
                label = Lang.Lang['pickup_tire_target'],
                distance = 2.0,
                icon = "fa-solid fa-hand",
                onSelect = function()
                    DeleteObject(tireProp)
                    TriggerServerEvent('v-vehiclesab:giveTire', closestVehicle, tireProp, wheelPos)
                end
            }
        })
    else
        print("Attempted to interact with a non-existent tire prop.")
    end
end)

function GetWheelOffset(vehicle, wheelIndex)
    local offset = vector3(0.0, 0.0, 0.0)
    if wheelIndex == 0 then -- Front Left
        offset = vector3(-0.9, 1.5, -0.5)
    elseif wheelIndex == 1 then -- Front Right
        offset = vector3(0.9, 1.5, -0.5)
    elseif wheelIndex == 2 then -- Rear Left
        offset = vector3(-0.9, -1.5, -0.5)
    elseif wheelIndex == 3 then -- Rear Right
        offset = vector3(0.9, -1.5, -0.5)
    end

    return offset
end

exports('useSpanner', function(data)
    loosenWheelNuts()
end)
