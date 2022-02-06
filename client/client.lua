ESX = nil

local canthermite = false
local successful = false

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

function FirstLoadup()
    CreateTargets() 
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function UnAuthJob()
	while ESX == nil do
		Citizen.Wait(0)
	end
	local UnAuthjob = false
	for i,v in pairs(Config.UnAuthJobs) do
		if PlayerData.job.name == v then
			UnAuthjob = true
			break
		end
	end

	return UnAuthjob
end

local CircleZone = CircleZone:Create(vector3(-596.30, -283.90, 50.3236), 1.0, {
    name="circle_zone",
    debugPoly=false,
})

Citizen.CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        nearFuseBox = CircleZone:isPointInside(coords)
        Citizen.Wait(500)
        if nearFuseBox then
            canthermite = true
        end
    end
end)

RegisterNetEvent('norp_vdoors:set')
AddEventHandler('norp_vdoors:set', function(doorId, isLocked)
    DoorSystemSetDoorState(doorId, isLocked and 1 or 0)
end)

RegisterNetEvent('norp_vdoors:initialize')
AddEventHandler('norp_vdoors:initialize', function(allDoors)
    for doorId, door in pairs(allDoors) do
        AddDoorToSystem(doorId, door.Model, door.Coordinates)
        DoorSystemSetDoorState(doorId, door.Locked and 1 or 0)
    end
end)

RegisterNetEvent('norp_vangelico:thermite')
AddEventHandler('norp_vangelico:thermite', function()
    local playercoords = GetEntityCoords(PlayerPedId())
   
    if canthermite then
        RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
        RequestModel('hei_p_m_bag_var22_arm_s')
        RequestNamedPtfxAsset('scr_ornate_heist')
        while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') and not HasModelLoaded('hei_p_m_bag_var22_arm_s') and not HasNamedPtfxAssetLoaded('scr_ornate_heist') do
            Citizen.Wait(50)
        end
        TaskGoStraightToCoord(PlayerPedId(), -596.26, -283.82, 50.3236, 1.0, -1, 299.32, 0.0)
        Citizen.Wait(2000)
        -- SetEntityCoords(PlayerPedId(), -596.30, -283.90, 50.3237)

        exports['memorygame']:thermiteminigame(10, 3, 3, 10,
        function() -- success
            --print("success")
            local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
            local bagscene = NetworkCreateSynchronisedScene(-596.14, -283.74, 50.3236, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
            local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), -596.14, -283.74, 50.3236,  true,  true, false)

            SetEntityCollision(bag, false, true)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), bagscene, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.2, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
            SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
            NetworkStartSynchronisedScene(bagscene)
            Citizen.Wait(1500)
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            local thermite = CreateObject(GetHashKey('hei_prop_heist_thermite'), x, y, z + 0.3,  true,  true, true)

            SetEntityCollision(thermite, false, true)
            AttachEntityToEntity(thermite, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
            Citizen.Wait(2000)
            DeleteObject(bag)
            SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)
            DetachEntity(thermite, 1, 1)
            FreezeEntityPosition(thermite, true)
            TriggerServerEvent('norp_vangelico:particleserver', method)
			SetPtfxAssetNextCall('scr_ornate_heist')
            local effect = StartParticleFxLoopedAtCoord('scr_heist_ornate_thermal_burn', -596.14, -282.74, 50.3236, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

            
            NetworkStopSynchronisedScene(bagscene)
            TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_intro', 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
            TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_loop', 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
            Citizen.Wait(10000)
            ClearPedTasks(PlayerPedId())
            DeleteObject(thermite)
            StopParticleFxLooped(effect, 0)
            successful = true
            TriggerServerEvent('norp_vangelico:thermitedelete')
			ExecuteCommand('vdoors 1')
            ExecuteCommand('vdoors 2')
			--DoorSystemSetDoorState(1425919976, 0, false, false)
			--DoorSystemSetDoorState(9467943, 0, false, false)
        end,
        function() -- failure
			TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Thermite failed.'})
            TriggerServerEvent('norp_vangelico:thermitedelete')
        end)
    end
end)

RegisterNetEvent('norp_vangelico:ptfxparticle')
AddEventHandler('norp_vangelico:ptfxparticle', function(method)
    local ptfx

    RequestNamedPtfxAsset('scr_ornate_heist')
    while not HasNamedPtfxAssetLoaded('scr_ornate_heist') do
        Citizen.Wait(1)
    end
        ptfx = vector3(-596.14, -282.74, 50.3236)
    SetPtfxAssetNextCall('scr_ornate_heist')
    local effect = StartParticleFxLoopedAtCoord('scr_heist_ornate_thermal_burn', ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    
    StopParticleFxLooped(effect, 0)
end)

local weaponTypes = {
    ["2685387236"] = { "Unarmed", ["slot"] = 0 },
    ["3566412244"] = { "Melee", ["slot"] = 1 },
    ["-728555052"] = { "Melee", ["slot"] = 1 },
    ["416676503"] = { "Pistol", ["slot"] = 2 },
    ["3337201093"] = { "SMG", ["slot"] = 3 },
    ["970310034"] = { "AssaultRifle", ["slot"] = 4 },
    ["-957766203"] = { "AssaultRifle", ["slot"] = 4 },
    ["3539449195"] = { "DigiScanner", ["slot"] = 4 },
    ["4257178988"] = { "FireExtinguisher", ["slot"] = 0 },
    ["1159398588"] = { "MG", ["slot"] = 4 },
    ["3493187224"] = { "NightVision", ["slot"] = 0 },
    ["431593103"] = { "Parachute", ["slot"] = 0 },
    ["860033945"] = { "Shotgun", ["slot"] = 3 },
    ["3082541095"] = { "Sniper", ["slot"] = 3 },
    ["690389602"] = { "Stungun", ["slot"] = 1 },
    ["2725924767"] = { "Heavy", ["slot"] = 4 },
    ["1548507267"] = { "Thrown", ["slot"] = 0 },
    ["1595662460"] = { "PetrolCan", ["slot"] = 1 }
}

--local _,wep = GetCurrentPedWeapon(playerPed)
local jewelry1 = false
local jewelry2 = false
local jewelry3 = false
local jewelry4 = false
local jewelry5 = false
local jewelry5 = false
local jewelry6 = false
local jewelry7 = false
local jewelry8 = false
local jewelry9 = false
local jewelry10 = false
local jewelry11 = false
local jewelry12 = false
local jewelry13 = false
local jewelry14 = false
local jewelry15 = false
local jewelry16 = false
local jewelry17 = false
local jewelry18 = false
local jewelry19 = false
local jewelry20 = false

function weaponTypeC()
	local w = GetSelectedPedWeapon(PlayerPedId())
	local wg = GetWeapontypeGroup(w)
	if weaponTypes[""..wg..""] then
		return weaponTypes[""..wg..""]["slot"]
	else
		return 0
	end
end

function giveitems()
    TriggerServerEvent('norp_vangelico:rewards')
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
end

local showcases = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},--
	{x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},--
	{x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},--
	{x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},--
	{x = -625.77, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},--
	{x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},--
	{x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},--
	{x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},--
	{x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},--
	{x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},--
	{x = -619.225, y = -233.677, z = 38.057, heading = 213.35, isOpen = false},--
	{x = -620.025, y = -233.354, z = 38.057, heading = 34.18, isOpen = false},--
	{x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},--
	{x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},--
	{x = -619.741, y = -230.32, z = 38.057, heading = 124.283, isOpen = false},--
	{x = -619.69, y = -227.61, z = 38.057, heading = 305.245, isOpen = false},--
	{x = -620.481, y = -226.59, z = 38.057, heading = 304.677, isOpen = false},--
	{x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},--
	{x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},--
	{x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},--
	{x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},--
}

function animation()
	local playerPos = GetEntityCoords(PlayerPedId(), true)
    loadAnimDict('missheist_jewel')
    for i,v in pairs(showcases) do 
        if #(playerPos - vector3(v.x, v.y, v.z)) < 0.75 then
            SetEntityCoords(PlayerPedId(), v.x, v.y, v.z-0.95)
            SetEntityHeading(PlayerPedId(), v.heading)
            TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
            while not HasNamedPtfxAssetLoaded('scr_jewelheist') do
                RequestNamedPtfxAsset('scr_jewelheist')
                Citizen.Wait(0)
            end
            PlaySoundFromCoord(-1, 'Glass_Smash', playerPos.x, playerPos.y, playerPos.z, "", 0, 2.0, 0)
            SetPtfxAssetNextCall('scr_jewelheist')
            StartParticleFxLoopedAtCoord('scr_jewel_cab_smash', v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                
            Citizen.Wait(5000)
            ClearPedTasks(PlayerPedId())
        end
    end
end

RegisterNetEvent('norp_vangelico:loot1')
AddEventHandler('norp_vangelico:loot1', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry1 then
            animation()
            giveitems()
            jewelry1 = true
        else
			TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
		TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry1 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot2')
AddEventHandler('norp_vangelico:loot2', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry2 then
            animation()
            giveitems()
            jewelry2 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry2 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot3')
AddEventHandler('norp_vangelico:loot3', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry3 then
            animation()
            giveitems()
            jewelry3 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry3 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot4')
AddEventHandler('norp_vangelico:loot4', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry4 then
            animation()
            giveitems()
            jewelry4 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry4 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot5')
AddEventHandler('norp_vangelico:loot5', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry5 then
            animation()
            giveitems()
            jewelry5 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry5 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot6')
AddEventHandler('norp_vangelico:loot6', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry6 then
            animation()
            giveitems()
            jewelry6 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry6 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot7')
AddEventHandler('norp_vangelico:loot7', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry7 then
            animation()
            giveitems()
            jewelry7 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry7 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot8')
AddEventHandler('norp_vangelico:loot8', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry8 then
            animation()
            giveitems()
            jewelry8 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry8 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot9')
AddEventHandler('norp_vangelico:loot9', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry9 then
            animation()
            giveitems()
            jewelry9 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry9 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot10')
AddEventHandler('norp_vangelico:loot10', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry10 then
            animation()
            giveitems()
            jewelry10 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry10 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot11')
AddEventHandler('norp_vangelico:loot11', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry11 then
            animation()
            giveitems()
            jewelry11 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry11 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot12')
AddEventHandler('norp_vangelico:loot12', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry12 then
            animation()
            giveitems()
            jewelry12 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry12 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot13')
AddEventHandler('norp_vangelico:loot13', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry13 then
            animation()
            giveitems()
            jewelry13 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry13 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot14')
AddEventHandler('norp_vangelico:loot14', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry14 then
            animation()
            giveitems()
            jewelry14 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry14 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot15')
AddEventHandler('norp_vangelico:loot15', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry15 then
            animation()
            giveitems()
            jewelry15 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry15 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot16')
AddEventHandler('norp_vangelico:loot16', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry16 then
            animation()
            giveitems()
            jewelry16 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry16 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot17')
AddEventHandler('norp_vangelico:loot17', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry17 then
            animation()
            giveitems()
            jewelry17 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry17 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot18')
AddEventHandler('norp_vangelico:loot18', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry18 then
            animation()
            giveitems()
            jewelry18 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry18 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot19')
AddEventHandler('norp_vangelico:loot19', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry19 then
            animation()
            giveitems()
            jewelry19 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry19 = false
    end
end)

RegisterNetEvent('norp_vangelico:loot20')
AddEventHandler('norp_vangelico:loot20', function()
    if weaponTypeC() > 1 and successful then
        if not jewelry20 then
            animation()
            giveitems()
            jewelry20 = true
        else
            TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Already looted this case.'})
        end
    else
        TriggerEvent('ox_inventory:notify', {type = 'error', text = 'Try something stronger than your fists.'})
        jewelry20 = false
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 50)
        if jewelry1 and jewelry2 and jewelry3 and jewelry4 and jewelry5 and jewelry6 and jewelry7 and jewelry8 and jewelry9 and jewelry10 and jewelry11 and jewelry12 and jewelry13 and jewelry14 and jewelry15 and jewelry16 and jewelry17 and jewelry18 and jewelry19 and jewelry20 then
            sleep = 0
            for i = 1, #players, 1 do
                TriggerServerEvent('norp_vangelico:allnotify', GetPlayerServerId(players))
            end
            Citizen.Wait(600000)
            ExecuteCommand('vdoors 1')
            ExecuteCommand('vdoors 2')
        end 
        Citizen.Wait(sleep)
    end
end)

exports['qtarget']:AddBoxZone('alarmbox', vector3(-595.94, -283.69, 50.32), 0.8, 0.25, {
	name='alarmbox',
	heading=30,
	--debugPoly=true,
	minZ=50.12,
	maxZ=51.32,
	}, {
		options = {
			{
                event = 'norp_vangelico:thermite',
                icon = 'fas fa-bomb',
                label = 'Disrupt Security',
                item = 'thermite',
			},
		},
		distance = 1.5
})

function CreateTargets()
    for k,v in pairs(Config.Showcases) do
        exports['qtarget']:AddBoxZone('Case_Zone'..k, v.location, v.size[1], v.size[2],
            {
                name = 'Case_Zone'..k,
                heading = v.heading,
                debugPoly = true,
                minZ = v.zcoords[1],
                maxZ = v.zcoords[2],
            }, {
                options = {{
                    icon = 'fas fa-gem', 
                    label = 'Steal Jewels',
                    event = v.event,
    
                }},
                distance = 1.5
            }
        )
    end
end

RegisterNetEvent('norp_vangelico:policenotify')
AddEventHandler('norp_vangelico:policenotify', function()
	for i, v in pairs(Config.PoliceJobs) do
		if  PlayerData.job.name == v then  
			ESX.ShowAdvancedNotification('911 Emergency', 'Silent Alarm' , 'Vangelico Jewelry Store', 'CHAR_CALL911', 1)
			TriggerEvent('norp_vangelico:alarmBlip')
		end
	end
end)

AddEventHandler('norp_vangelico:alarmBlip', function()
	local transT = 250
	local Blip = AddBlipForCoord(-634.02, -239.49, 38)
	SetBlipSprite(Blip,  10)
	SetBlipColour(Blip,  1)
	SetBlipAlpha(Blip,  transT)
	SetBlipAsShortRange(Blip,  false)
	while transT ~= 0 do
		Wait(100)
		transT = transT - 1
		SetBlipAlpha(Blip,  transT)
		if transT == 0 then
			SetBlipSprite(Blip,  2)
			return
		end
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (resourceName == GetCurrentResourceName() and Config.Debug) then
        while (ESX == nil) do Citizen.Wait(100) end        
        Citizen.Wait(5000)
        ESX.PlayerLoaded = true
        FirstLoadup()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    while (ESX == nil) do Citizen.Wait(100) end    
    Citizen.Wait(5000)
    ESX.PlayerData = xPlayer
 	ESX.PlayerLoaded = true
    FirstLoadup()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)