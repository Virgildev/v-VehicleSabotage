RegisterNetEvent('v-vehiclesab:removeWheelKit')
AddEventHandler('v-vehiclesab:removeWheelKit', function()
    local src = source
    exports.ox_inventory:RemoveItem(src, 'wheelremover', 1)
end)