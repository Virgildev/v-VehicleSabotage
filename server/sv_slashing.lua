RegisterServerEvent('v-vehiclesab:slashTire')
AddEventHandler('v-vehiclesab:slashTire', function(networkId, wheelIndex)
    local src = source

    TriggerClientEvent('v-vehiclesab:popTire', -1, networkId, wheelIndex)
    
    TriggerClientEvent('ox_lib:notify', src, {
        title = Lang.Lang['tire_slashing_title'],
        description = Lang.Lang['tire_slash_success'],
        type = 'success'
    })
end)