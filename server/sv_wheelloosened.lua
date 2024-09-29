RegisterNetEvent('v-vehiclesab:giveTire')
AddEventHandler('v-vehiclesab:giveTire', function()
    local source = source
    exports.ox_inventory:AddItem(source, Config.WheelItem, Config.WheelItemAmount)
end)

RegisterNetEvent('v-vehiclesab:useSpanner')
AddEventHandler('v-vehiclesab:useSpanner', function()
    local source = source
    exports.ox_inventory:RemoveItem(source, 'wheelspanner', 1)
end)
