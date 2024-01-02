local QBCore = exports['qb-core']:GetCoreObject()

-- Events
RegisterServerEvent('Flowers:server:getItem', function(itemlist)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemlist = itemlist
    local removed = false
    for k, v in pairs(itemlist) do
        if v.threshold > math.random(0, 100) then
            Player.Functions.AddItem(v.name, math.random(1, v.max))
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.name], "add")
            if v.remove ~= nil and not removed then
                removed = true
                Player.Functions.RemoveItem(v.remove, 1)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.remove], "remove")
            end
        end
    end
end)

RegisterNetEvent('Flowers:server:sellflower_bulck', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
		local flower_bulck = Player.Functions.GetItemByName("flower_bulck")
		if flower_bulck ~= nil then
			local payment = 200 -- sell price for item
			Player.Functions.RemoveItem("flower_bulck", 1, k)
			Player.Functions.AddMoney('bank', payment , "flower_bulck-sell")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["flower_bulck"], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, " 1 Sold for $"..payment, "success")
			TriggerClientEvent("Flowers:client:sellflower_bulck", source)
		else
		    TriggerClientEvent('QBCore:Notify', src, "you have nothing to sell", "error")
        end 
    end
end)

QBCore.Functions.CreateUseableItem("scissors", function(source, item)
	local src = source
    TriggerClientEvent('Flowers:client:startpicking', src)
end)

QBCore.Functions.CreateUseableItem("flower_paper", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName("flower")
    if item ~= nil then
        TriggerClientEvent('Flowers:client:startpack', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You have nothing to make!..', 'error')
    end
end)
