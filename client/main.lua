-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local inPickingArea = false
local inPackingArea = false
local currentspot = nil
local previousspot = nil
local PickingLocations = {}
local PackingLocations = {}
local Blips = {}
local mineWait = false

-- Functions

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
       return tostring(o)
    end
end

local function loadModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
        RequestModel(model)
    end
    return model
end

local function loadDict(dict, anim)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
        RequestAnimDict(dict)
    end
    return dict
end

local function helpText(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

local function addBlip(coords, sprite, colour, scale, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

local function CreateBlips() -- Create mining blips
	for k, v in pairs(Config.Blips) do
        Blips[k] = AddBlipForCoord(v.blippoint)
        SetBlipSprite(Blips[k], v.blipsprite)
        SetBlipDisplay(Blips[k], 4)
        SetBlipScale(Blips[k], v.blipscale)
        SetBlipAsShortRange(Blips[k], true)
        SetBlipColour(Blips[k], v.blipcolour)
        SetBlipAlpha(Blips[k], 0.7)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(Blips[k])
    end
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() -- Event when player has successfully loaded
    TriggerEvent('Flowers:client:DestroyZones') -- Destroy all zones
	Wait(100)
	TriggerEvent('Flowers:client:UpdatePickingZones') -- Reload mining information
	Wait(100)
	TriggerEvent('Flowers:client:UpdatePackingZones') -- Reload smelting information
	Wait(100)
	CreateBlips() --Reload blips
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function() -- Reset all variables
	TriggerEvent('Flowers:client:DestroyZones') -- Destroy all zones
	inPickingArea = false
    currentspot = nil
    previousspot = nil
    PickingLocations = {}
    PackingLocations = {}
	Blips = {}
	Peds = {}
end)

AddEventHandler('onResourceStart', function(resource) -- Event when resource is reloaded
    if resource == GetCurrentResourceName() then -- Reload player information
		TriggerEvent('Flowers:client:DestroyZones') -- Destroy all zones
		Wait(100)
		TriggerEvent('Flowers:client:UpdatePickingZones') -- Reload mining information
		Wait(100)
		TriggerEvent('Flowers:client:UpdatePackingZones') -- Reload smelting information
		Wait(100)
		CreateBlips()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then -- Reload player information
		TriggerEvent('Flowers:client:DestroyZones') -- Destroy all zones
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) --Events when players change jobs
    TriggerEvent('Flowers:client:DestroyZones') -- Destroy all zones
	Wait(100)
	TriggerEvent('Flowers:client:UpdatePickingZones') -- Reload mining information
	Wait(100)
	TriggerEvent('Flowers:client:UpdatePackingZones') -- Reload smelting information
	Wait(100)
	CreateBlips() --Reload blips
end)

RegisterNetEvent('Flowers:client:UpdatePickingZones', function() -- Update Picking Zones
    for k, v in pairs(Config.Picking) do
        PickingLocations[k] = PolyZone:Create(v.zones, {
            name='Picking '..k,
            minZ = 	v.minz,
            maxZ = v.maxz,
            debugPoly = false
        })
    end
end)

RegisterNetEvent('Flowers:client:UpdatePackingZones', function() -- Update Packing Zones
    for k, v in pairs(Config.Packing) do
        PackingLocations[k] = PolyZone:Create(v.zones, {
            name='PackingStation '..k,
            minZ = 	v.minz,
            maxZ = v.maxz,
            debugPoly = false
        })
    end
end)

RegisterNetEvent('Flowers:client:DestroyZones', function() -- Destroy all zones
    if PickingLocations then
		for k, v in pairs(PickingLocations) do
			PickingLocations[k]:destroy()
		end
	end
    if PackingLocations then
		for k, v in pairs(PackingLocations) do
			PackingLocations[k]:destroy()
		end
	end
	PickingLocations = {}
    PackingLocations = {}
end)

RegisterNetEvent('Flowers:client:startpicking', function() -- Start mining
	if not pickWait then
		pickWait = true
		SetTimeout(5000, function()
			pickWait = false
		end)
		local Ped = PlayerPedId()
		local coord = GetEntityCoords(Ped)
		for k, v in pairs(PickingLocations) do
			if PickingLocations[k] then
				if PickingLocations[k]:isPointInside(coord) then
					--local model = loadModel(`p_cs_scissors_s`)
					--local axe = CreateObject(model, GetEntityCoords(Ped), true, false, false)
				--	AttachEntityToEntity(axe, Ped, GetPedBoneIndex(Ped, 57005), 0.09, 0.23, -0.02, -78.0, -11.0, 90.0, false, true, true, true, 0, true)
					QBCore.Functions.Progressbar("startpicking", "Cutting Flowers", 3000, false, false, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
                    }, {
						animDict = "anim@gangops@facility@servers@", 
						anim = "hotwire", 
						flags = 8,
					}, {}, {}, function() -- Done
						Wait(1000)
                                                StopAnimTask(Ped, "anim@gangops@facility@servers@", "startpicking", 1.0)
						ClearPedTasks(Ped)
						DeleteObject(axe)
						TriggerServerEvent('Flowers:server:getItem', Config.PickingItems)
						QBCore.Functions.Notify("you picked a flower", "success")
					end)
				end
			end
		end
	else
		QBCore.Functions.Notify("you cant get it from here", "error")
	end
end)

RegisterNetEvent('Flowers:client:startpack', function() -- Start smelting
	local Ped = PlayerPedId()
	local coord = GetEntityCoords(Ped)
	for k, v in pairs(PackingLocations) do
		if PackingLocations[k] then 
			if PackingLocations[k]:isPointInside(coord) then
				QBCore.Functions.Progressbar("startpack", "Proccesing", 6000, false, false, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_arresting", 
					anim = "a_uncuff",
					flags = 8,
				}, {}, {}, function() -- Done
					StopAnimTask(Ped, "mp_arresting", "startpack", 1.0)
					ClearPedTasks(Ped)
					TriggerServerEvent('Flowers:server:getItem', Config.PackingItems)
					QBCore.Functions.Notify("you made it", "success")					
				end)
			end
		end
	end
end)

-- Selling
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('Flowers:client:sellflower_bulck')
AddEventHandler('Flowers:client:sellflower_bulck', function()
    exports['qb-menu']:openMenu({
		{
            header = "Dealer",
            isMenuHeader = true
        },
        {
            header = "Flower Dealer",
            txt = "Sell Flowers here",
            params = {
				isServer = true,
                event = "Flowers:server:sellflower_bulck",
				args = 1 
            }
        },			
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

-- Ped Spawn
local dealerPed = {
	{2588.3438, 3167.8176, 50.3673,"EL Trope",320.63,0x7E4F763F,"g_m_m_chigoon_01"}, -- Ped dealer
  
  }
  Citizen.CreateThread(function()
	  for _,v in pairs(dealerPed) do
		  RequestModel(GetHashKey(v[7]))
		  while not HasModelLoaded(GetHashKey(v[7])) do
			  Wait(1)
		  end
		  CokeProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
		  SetEntityHeading(CokeProcPed, v[5])
		  FreezeEntityPosition(CokeProcPed, true)
		  SetEntityInvincible(CokeProcPed, true)
		  SetBlockingOfNonTemporaryEvents(CokeProcPed, true)
		  TaskStartScenarioInPlace(CokeProcPed, "WORLD_HUMAN_CLIPBOARD", 0, true) 
	  end
  end)

-- Target
exports['qb-target']:AddBoxZone("flower_bulckpicking", vector3(2588.767, 3168.427, 51.165), 1, 1, {
	name = "flower_bulckpicking",
	heading = 135,
	debugPoly = false,
	minZ = 49.30,
	maxZ = 53.0,
}, {
	options = {
		{
                type = "client",
                event = "Flowers:client:sellflower_bulck",
	        icon = "fas fa-seedling",
		label = "Sell Flowers",
		},
	},
	distance = 2.5
})
