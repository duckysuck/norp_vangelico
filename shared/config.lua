Config = {}

Config.Debug = true

Config.MinPolice = 0

Config.ResetTime = 60

Config.showblip = true
Config.blipcoords = vector3(-622.6827, -231.3588, 38.0570)

Config.Doors = {
    leftdoor = {
        Model       = 1425919976,
        Coordinates = vector3(-631.9554, -236.3333, 38.20653),
        Locked      = true,
    },
    rightdoor = {
        Model       = 9467943,
        Coordinates = vector3(-630.4265, -238.4375, 38.20653),
        Locked      = true,
    },
}

Config.Showcases = {
    S1 = {
        location = vector3(-626.35, -239.0, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S2 = {
        location = vector3(-625.31, -238.27, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S3 = {
        location = vector3(-627.2, -234.92, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S4 = {
        location = vector3(-626.13, -234.15, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S5 = {
        location = vector3(-626.57, -233.58, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S6 = {
        location = vector3(-627.62, -234.34, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S7 = {
        location = vector3(-624.0, -230.76, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S8 = {
        location = vector3(-622.65, -232.61, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S9 = {
        location = vector3(-620.49, -232.92, 38.06),
        heading = 36,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S10 = {
        location = vector3(-619.87, -234.89, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S11 = {
        location = vector3(-618.82, -234.1, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S12 = {
        location = vector3(-617.14, -230.19, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S13 = {
        location = vector3(-617.89, -229.13, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S14 = {
        location = vector3(-620.16, -230.77, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S15 = {
        location = vector3(-621.49, -228.93, 38.06),
        heading = 36,
        zcoords = {37.81, 38.26},
        size = {1.2, 0.6,},
    },
    S16 = {
        location = vector3(-619.23, -227.26, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S17 = {
        location = vector3(-619.99, -226.2, 38.06),
        heading = 306,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S18 = {
        location = vector3(-623.64, -228.59, 38.06),
        heading = 36,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S19 = {
        location = vector3(-624.26, -226.64, 38.06),
        heading = 36,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
    S20 = {
        location = vector3(-625.31, -227.39, 38.06),
        heading = 36,
        zcoords = {37.81, 38.26},
        size = {0.6, 1.2,},
    },
}

Config.ItemDrops  = {
    { name = 'goldbar', max = 1,  chance = 1 },
    { name = 'goldchain', max = 3, chance = 20 },
    { name = 'silverrings', max = 5,  chance = 20 },
    { name = 'goldrings', max = 5,  chance = 20 },
    { name = 'pearlearrings', max = 10, chance = 50 },
    { name = 'bluebronzewatch', max = 10, chance = 100 },
    { name = 'diamond_ring', max = 10, chance = 25 },
    { name = 'onxyearring', max = 10, chance = 15 },
    { name = 'emerald', max = 10, chance = 15 },
    { name = 'diamond', max = 10, chance = 10 },
    { name = 'tristonering', max = 10, chance = 30 },
    { name = 'skeletonwatch', max = 10, chance = 75 },
    { name = 'goldskull', max = 10, chance = 1 },
    { name = 'jewelrybox', max = 10, chance = 5 },
 }

 Config.AllowedWeapons = {
    { name = 'WEAPON_PISTOL', chance = 30 },
    { name = 'WEAPON_SMG', chance = 40 },
    { name = 'WEAPON_CROWBAR', chance = 18 },
 }

 Config.PoliceJobs =  {
    'police',
    'sheriff',
 }

 Config.UnAuthJobs = {
    'police', 
    'sheriff', 
    'ambulance', 
 }
