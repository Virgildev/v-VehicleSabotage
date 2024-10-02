local QBCore = exports['qb-core']:GetCoreObject()

local lastBombUse = 0
local armedVehicles = {}

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

local function monitorEngineStart(vehicle)
    local vehicleNetID = NetworkGetEntityNetScriptId(vehicle)
    CreateThread(function()
        while DoesEntityExist(vehicle) do
            if GetIsVehicleEngineRunning(vehicle) and armedVehicles[vehicleNetID] then
                Wait(1500)
                TriggerServerEvent('v-vehiclesab:detonateBomb', vehicleNetID)
                return
            end
            Wait(500)
        end
    end)
end

local function plantCarBomb(vehicle)
    local vehicleNetID = NetworkGetEntityNetScriptId(vehicle)

    armedVehicles[vehicleNetID] = true

    TriggerServerEvent('v-vehiclesab:plantCarBomb', vehicleNetID)

    lib.notify({
        description = 'Car bomb planted successfully!',
        type = 'success'
    })

    exports.ox_target:addLocalEntity(vehicle, {
        {
            label = Lang.Lang['disarm_bomb_target'],
            icon = "fa-solid fa-scissors",
            item = 'disarm_kit',
            distance = 2.0,
            onSelect = function()
                handleDisarmInteraction(vehicle)
            end
        }
    })

    monitorEngineStart(vehicle)
end

local function disarmCarBomb(vehicle)
    local vehicleNetID = NetworkGetEntityNetScriptId(vehicle)

    if armedVehicles[vehicleNetID] then
        local skillCheckSuccess = lib.skillCheck(Config.CarBombDisarmSkillcheck.difficulty, Config.CarBombDisarmSkillcheck.keys)
        
        if skillCheckSuccess then
            if lib.progressCircle({
                duration = 6000,
                position = 'bottom',
                label = Lang.Lang['bomb_disarm_progress'],
                canCancel = true,
                disable = {sprint = true, car = true},
                anim = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    clip = 'machinic_loop_mechandplayer'
                }
            }) then
                armedVehicles[vehicleNetID] = nil
                TriggerServerEvent('v-vehiclesab:removeBomb', vehicleNetID)

                lib.notify({
                    description = Lang.Lang['bomb_disarmed'],
                    type = 'success'
                })

                exports.ox_target:removeLocalEntity(vehicle, 'Disarm Car Bomb')
            else
                TriggerServerEvent('v-vehiclesab:detonateBomb', vehicleNetID)
            end
        else
            TriggerServerEvent('v-vehiclesab:detonateBomb', vehicleNetID)
        end
    else
        lib.notify({
            description = Lang.Lang['no_vehicle_found'],
            type = 'info'
        })
    end
end

RegisterNetEvent('v-vehiclesab:detonateBombClient')
AddEventHandler('v-vehiclesab:detonateBombClient', function(vehicleNetID)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetID)
    if DoesEntityExist(vehicle) then
        local vehicleCoords = GetEntityCoords(vehicle)
        AddExplosion(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0, 10.0, true, false, 1.0)
        DeleteObject(vehicle)
    end
end)

RegisterNetEvent('v-vehiclesab:removeBombClient')
AddEventHandler('v-vehiclesab:removeBombClient', function(vehicleNetID)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetID)
    if DoesEntityExist(vehicle) then
        armedVehicles[vehicleNetID] = nil
    end
end)

function handleDisarmInteraction(vehicle)
    disarmCarBomb(vehicle)
end

exports('bombPlantKit', function()
    useBombKit()
end)

function useBombKit()
    local currentTime = GetGameTimer()
    if currentTime - lastBombUse < Config.CarBombCooldown then
        lib.notify({
            description = Lang.Lang['cooldown_active'],
            type = 'error'
        })
        return
    end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(playerCoords)

    local vpDist = #(playerCoords - GetEntityCoords(vehicle))

    if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) and vpDist <= 5 then
        local skillCheckSuccess = lib.skillCheck(Config.CarBombSkillcheck.difficulty, Config.CarBombSkillcheck.keys)
        
        if skillCheckSuccess then
            if lib.progressCircle({
                duration = Config.CarBombDisarmProgress,
                position = 'bottom',
                label = Lang.Lang['planting_carbomb_progress'],
                canCancel = true,
                disable = {sprint = true, car = true},
                anim = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    clip = 'machinic_loop_mechandplayer'
                }
            }) then
                lastBombUse = currentTime
                TriggerServerEvent('v-vehiclesab:carBombitem')
                plantCarBomb(vehicle)
            else
                TriggerServerEvent('v-vehiclesab:detonateBomb', vehicle)
            end
        else
            TriggerServerEvent('v-vehiclesab:detonateBomb', vehicle)
        end
    else
        lib.notify({
            description = Lang.Lang['no_vehicle_found'],
            type = 'error'
        })
    end
end

exports('bombPlantKit', function()
    useBombKit()
end)
