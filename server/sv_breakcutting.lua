local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('v-vehiclesab:cuttingComplete', function(vehicleNetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if DoesEntityExist(vehicle) then
        local success, response = exports.ox_inventory:RemoveItem(src, 'break_cutting_tool', 1)

        if success then
            TriggerClientEvent('v-vehiclesab:disableBrakes', src, vehicleNetId)
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = response})
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = Lang.Lang.no_vehicle_found})
    end
end)
