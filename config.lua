Config = {}

Config.PickingItems = {
    [1] = {
        name = "flower",
        threshold = 80,
        max = 1,
        remove = nil,
    },
}

Config.PackingItems = {
    [1] = {
        name = "flower_bulck",
        threshold = 80,
        max = 3,
        remove = "flower",
    },
}

Config.Blips = {
    {
        blippoint = vector3(1590.816, 2167.511, 79.453),
        blipsprite = 489,
        blipscale = 0.65,
        blipcolour = 1,
        label = "Flowers"
    },
    {
        blippoint = vector3(1540.929, 2178.772, 78.814),
        blipsprite = 489,
        blipscale = 0.65,
        blipcolour = 1,
        label = "Packing"
    },
    {
        blippoint = vector3(2588.767, 3168.427, 51.165),
        blipsprite = 489,
        blipscale = 0.65,
        blipcolour = 1,
        label = "Flowers Buyer"
    },

}

Config.Picking = {
    [1] = {
        zones = { 
            vector2(1593.047, 2161.669),
            vector2(1592.131, 2156.931),
            vector2(1588.29, 2158.757),
            vector2(1589.696, 2162.112),
        },
        minz = 76.0,
        maxz = 82.0,
    },
    [2] = {
        zones = { 
            vector2(1589.792, 2172.557),
            vector2(1592.402, 2173.53),
            vector2(1589.273, 2177.923),
            vector2(1587.655, 2175.604),
        },
        minz = 76.0,
        maxz = 82.0,
    },
}

Config.Packing = {
    {
        zones = {
            vector2(1543.099, 2177.461),
            vector2(1543.377, 2179.69),
            vector2(1540.231, 2179.584),
            vector2(1539.934, 2177.412),
        },
        minz = 75.0,
        maxz = 81.0,
    },
}
