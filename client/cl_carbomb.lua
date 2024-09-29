local QBCore = exports['qb-core']:GetCoreObject()

function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

function plantCarBomb(vehicle)
    local vehiclePos = GetEntityCoords(vehicle)

    local bombModel = `ch_prop_ch_ld_bomb_01a`
    loadModel(bombModel)

    local bombPos = vector3(vehiclePos.x, vehiclePos.y, vehiclePos.z - 1.8)
    local bombRot = vector3(0.0, 90.0, 0.0)  -- Rotating 90 degrees along the Z-axis
    
    local bomb = CreateObject(bombModel, bombPos.x, bombPos.y, bombPos.z, true, true, true)
    
    -- Adjusting the attachment parameters for rotation
    AttachEntityToEntity(bomb, vehicle, 0, 0.0, -0.8, 0.1, 270.0, 90.0, 0.0, false, false, false, false, 2, true)    

    lib.notify({
        description = Lang.Lang['car_bomb_planted'],
        type = 'success'
    })

    exports.ox_target:addLocalEntity(vehicle, {
        {
            label = Lang.Lang['disarm_car_bomb_target'],
            icon = "fa-solid fa-scissors",
            item = Config.CarBombDisarmItem,
            distance = 2.0,
            onSelect = function()
                handleDisarmInteraction(bomb)
            end
        }
    })

    return bomb
end

function detonateBomb(bomb)
    if DoesEntityExist(bomb) then
        local bombCoords = GetEntityCoords(bomb)

        AddExplosion(bombCoords.x, bombCoords.y, bombCoords.z, 0, 10.0, true, false, 1.0)

        DeleteObject(bomb)

        lib.notify({
            description = Lang.Lang['bomb_detonated'],
            type = 'error'
        })
    end
end

function onEngineStart(vehicle, bomb)
    if GetIsVehicleEngineRunning(vehicle) then
        Wait(1500)
        detonateBomb(bomb)
    end
end

function useBombKit()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(playerCoords)

    if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
        local skillCheckSuccess = lib.skillCheck(Config.CarBombSkillcheck.difficulty, Config.CarBombSkillcheck.keys)
        
        if skillCheckSuccess then
            if lib.progressCircle({
                duration = Config.CarBombProgress,
                position = 'bottom',
                label = Lang.Lang['bomb_arm_progress'],
                canCancel = true,
                disable = {sprint = true, car = true},
                anim = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    clip = 'machinic_loop_mechandplayer'
                },
                prop = {
                    model = `prop_c4_final_green`,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 90.0)
                },
            }) then
                TriggerServerEvent('v-vehiclesab:carBombitem')
                local bomb = plantCarBomb(vehicle)
                CreateThread(function()
                    while DoesEntityExist(vehicle) and DoesEntityExist(bomb) do
                        if GetIsVehicleEngineRunning(vehicle) then
                            onEngineStart(vehicle, bomb)
                            break
                        end
                        Wait(500)
                    end
                end)
            else
                detonateBomb(vehicle)
            end
        else
            detonateBomb(vehicle)
        end
    else
        lib.notify({
            description = Lang.Lang['no_vehicle_found'],
            type = 'error'
        })
    end
end

function disarmCarBomb(bomb)
    if DoesEntityExist(bomb) then
        local skillCheckSuccess = lib.skillCheck(Config.CarBombDisarmSkillcheck.difficulty, Config.CarBombDisarmSkillcheck.keys)
        
        if skillCheckSuccess then
            if lib.progressCircle({
                duration = Config.CarBombDisarmProgress,
                position = 'bottom',
                label = Lang.Lang['bomb_disarm_progress'],
                canCancel = true,
                items = Config.CarBombDisarmItem,
                disable = {sprint = true, car = true},
                anim = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    clip = 'machinic_loop_mechandplayer'
                },
            }) then
                DeleteObject(bomb)
                exports.ox_target:removeLocalEntity(bomb, {"Disarm Car Bomb"})

                lib.notify({
                    description = Lang.Lang['bomb_disarmed'],
                    type = 'success'
                })
            else
                detonateBomb(bomb)
            end
        else
            detonateBomb(bomb)
        end
    else
        lib.notify({
            description = Lang.Lang['no_bomb_found'],
            type = 'info'
        })
    end
end

function handleDisarmInteraction(bomb)
    disarmCarBomb(bomb)
end

exports('bombPlantKit', function()
    useBombKit()
end)