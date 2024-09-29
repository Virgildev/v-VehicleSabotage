local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('v-vehiclesab:sabotageVehicle', function(coords)
    local chance = math.random(1, 100)

    if chance <= Config.ExplosionChance then
        Citizen.SetTimeout(Config.ExplosionDelay * 1000, function()
            TriggerClientEvent('v-vehiclesab:triggerExplosion', -1, coords)
        end)
        TriggerClientEvent('ox_lib:notify', source, {
            description = Lang.Lang.sabotage_failed,
            type = 'error',
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            description = Lang.Lang.sabotage_success,
            type = 'success',
        })
    end
end)
