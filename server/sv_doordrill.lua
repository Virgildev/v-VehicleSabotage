RegisterNetEvent('v-vehiclesab:removeDrillItem')
AddEventHandler('v-vehiclesab:removeDrillItem', function()
    local source = source
    local change = math.random(1, 100)
    if change <= Config.RemoveDrillChance then
        exports.ox_inventory:RemoveItem(source, Config.DoorRemoveItem, 1)
    end
end)

RegisterNetEvent('v-vehiclesab:carBombitem')
AddEventHandler('v-vehiclesab:carBombitem', function()
    local source = source
    exports.ox_inventory:RemoveItem(source, 'carbomb', 1)
end)