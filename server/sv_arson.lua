RegisterNetEvent('v-vehiclesab:removeArsonitem')
AddEventHandler('v-vehiclesab:removeArsonitem', function()
    local source = source
    exports.ox_inventory:RemoveItem(source, 'gascanister', 1)
end)
