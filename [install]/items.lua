--!!ox_inventory>data>items.lua!!--

return {
    ['break_cutting_tool'] = {
        label = 'Break Cutters',
        description = "Cut them breaks yo",
        consume = 0,
        weight = 100,
        client = {
            export = 'v-VehicleSabotage.break_cutting_tool'
        }
    },
    ["tankdrill"] = {
        label = "Large Bit Drill",
        weight = 300,
        stack = true,
        consume = 1,
        close = false,
        description = "The real deal...",
        client = {
            export = 'v-VehicleSabotage.drillTank'
        }
    },
    ["wheelremover"] = {
        label = "High Power Drill",
        weight = 300,
        stack = true,
        consume = 1,
        close = false,
        description = "The real deal...",
        client = {
            export = 'v-VehicleSabotage.wheelRemover'
        }
    },
    ["wheelspanner"] = {
        label = "Wheel Loosener",
        weight = 300,
        stack = true,
        consume = 1,
        close = false,
        description = "The real deal...",
        client = {
            export = 'v-VehicleSabotage.useSpanner'
        }
    },
    ["carbomb"] = {
        label = "Car Bomb",
        weight = 500,
        stack = true,
        consume = 1,
        close = false,
        description = "The real deal...",
        client = {
            export = 'v-VehicleSabotage.bombPlantKit'
        }
    },
    ["gascanister"] = {
        label = "Gas Canister",
        weight = 500,
        stack = true,
        consume = 1,
        close = false,
        description = "The real deal...",
        client = {
            export = 'v-VehicleSabotage.arsonKit'
        }
    },
}