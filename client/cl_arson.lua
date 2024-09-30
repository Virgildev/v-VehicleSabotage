local QBCore = exports['qb-core']:GetCoreObject()

local arsonCooldowns = {}

function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

function startFireAtLocation(coords)
    AddExplosion(coords.x, coords.y, coords.z, 23, 15.0, false, false, 0.0)
end

function removeVehiclePlate(vehicle)
    if DoesEntityExist(vehicle) then
        SetVehicleNumberPlateText(vehicle, "") 
    end
end

function torchVehicle(vehicle)
    if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
        local vehicleCoords = GetEntityCoords(vehicle)

        startFireAtLocation(vehicleCoords)

        removeVehiclePlate(vehicle)

        lib.notify({
            description = Lang.Lang['vehicle_torched'],
            type = 'success'
        })
    else
        lib.notify({
            description = Lang.Lang['no_vehicle_found'],
            type = 'error'
        })
    end
end

function getClosestVehicle()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    return QBCore.Functions.GetClosestVehicle(playerCoords)
end

function useArsonKit()
    local playerId = QBCore.Functions.GetPlayerData().citizenid

    local currentTime = GetGameTimer()
    if arsonCooldowns[playerId] and (currentTime - arsonCooldowns[playerId]) < (Config.ArsonCooldown * 1000) then
        local remainingTime = math.floor((Config.ArsonCooldown * 1000 - (currentTime - arsonCooldowns[playerId])) / 1000)
        lib.notify({
            description = Lang.Lang['must_wait'] .. remainingTime .. Lang.Lang['must_wait_2'],
            type = 'error'
        })
        return
    end

    arsonCooldowns[playerId] = currentTime

    local vehicle = getClosestVehicle()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    if vehicle and DoesEntityExist(vehicle) then
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z)

        if distance > 2.5 then
            lib.notify({
                description = Lang.Lang['vehicle_too_far'],
                type = 'error'
            })
            return
        end
    else
        startFireAtLocation(playerCoords)

        lib.notify({
            description = Lang.Lang['fire_started'],
            type = 'success'
        })
        return
    end

    local skillCheckSuccess = lib.skillCheck(Config.ArsonSkillcheck.difficulty, Config.ArsonSkillcheck.keys)

    if skillCheckSuccess then
        local progressSuccess = lib.progressCircle({
            duration = Config.ArsonProgress,
            position = 'bottom',
            label = Lang.Lang['placing_gasolinecanister_progress'],
            canCancel = true,
            disable = {sprint = true, car = true},
            anim = {
                dict = 'anim@scripted@heist@ig6_explosive_plant@male@',
                clip = 'plant_male'
            },
            prop = {
                model = `w_ex_vehiclegrenade`,
                pos = vec3(0.0, 0.15, 0.48),
                rot = vec3(0.0, 0.0, 90.5)
            },
        })

        if progressSuccess then
            TriggerServerEvent('v-vehiclesab:removeArsonitem')
            lib.notify({
                description = Lang.Lang['fire_starting'],
                type = 'success'
            })
            Citizen.Wait(5000)
            torchVehicle(vehicle)
        else
            lib.notify({
                description = Lang.Lang['action_canceled'],
                type = 'error'
            })
        end
    else
        startFireAtLocation(playerCoords)

        lib.notify({
            description = Lang.Lang['fire_started'],
            type = 'success'
        })
    end
end

exports('arsonKit', function()
    useArsonKit()
end)
