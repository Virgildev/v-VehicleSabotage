local QBCore = exports['qb-core']:GetCoreObject()

local lastCuttingTime = 0

exports('break_cutting_tool', function(data, slot)
    local currentTime = GetGameTimer()

    if currentTime - lastCuttingTime < Config.BreakCuttingCooldown then
        lib.notify({type = 'error', description = Lang.Lang['cooldown_active']})
        return
    end

    lastCuttingTime = currentTime

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    exports.ox_inventory:useItem(data, function(success)
        if success then
            local vehicle = QBCore.Functions.GetClosestVehicle(playerCoords)
            local distance = #(GetEntityCoords(vehicle) - playerCoords)

            if vehicle ~= 0 and distance <= 3.0 then

                local skillCheckSuccess = lib.skillCheck(Config.BreakCuttingSkillcheck.difficulty, Config.BreakCuttingSkillcheck.keys)

                if skillCheckSuccess then
                    local progressSuccess = lib.progressCircle({
                        duration = Config.BreakCuttingProgress,
                        label = Lang.Lang['cutting_breaks_progress'],
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        anim = {
                            dict = 'anim@heists@fleeca_bank@drilling',
                            clip = 'drill_straight_end',                 
                        },
                        prop = {
                            model = `prop_tool_consaw`, 
                            pos = vec3(0.04, 0.06, 0.20), --l/r, foward/back, up
                            rot = vec3(15.0, 0.0, 270.0)
                        },  
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        }
                    })

                    if progressSuccess then
                        local vehicleNetId = NetworkGetNetworkIdFromEntity(vehicle)
                        TriggerServerEvent('v-vehiclesab:cuttingComplete', vehicleNetId)
                    else
                        lib.notify({type = 'error', description = Lang.Lang['cutting_canceled']})
                    end
                else
                    lib.notify({type = 'error', description = Lang.Lang['skill_check_failed']})
                end
            else
                lib.notify({type = 'error', description = Lang.Lang['no_vehicle_nearby']})
            end
        else
            lib.notify({type = 'error', description = Lang.Lang['failed_to_use_tool']})
        end
    end)
end)

local lastBrakeCutTime = 0

RegisterNetEvent('v-vehiclesab:disableBrakes', function(vehicleNetId)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    local currentTime = GetGameTimer()

    if not DoesEntityExist(vehicle) then
        lib.notify({type = 'error', description = Lang.Lang['no_vehicle_found']})
        return
    end

    if currentTime - lastBrakeCutTime < Config.BreakCuttingCooldown then
        local remainingTime = math.ceil((Config.BreakCuttingCooldown - (currentTime - lastBrakeCutTime)) / 1000)
        lib.notify({type = 'error', description = string.format(Lang.Lang['cooldown_active'], remainingTime)})
        return
    end

    SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce', -0.01)
    SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fHandBrakeForce', -0.01)

    lib.notify({type = 'inform', description = Lang.Lang['brakes_cut']})
    lastBrakeCutTime = currentTime
end)