


# Flowers 

Flowers script for QBCore Framework

Any problems contact me via discord denni_al

# Installation

**Add to qb-shops/config.lua**

*Add into Config.Products*
```
    ["flowersupplies"] = {
        [1] = {
            name = 'scissors',
            price = 1500,
            amount = 1,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'flower_paper',
            price = 750,
            amount = 1,
            info = {},
            type = 'item',
            slot = 2,
        },  
    },
```
*Add into Config.Locations*
```
    ["flowersupplies"] = {
        ["label"] = "Flower Supplies",
        ["coords"] = vector4(-385.191, 270.856, 86.368, 303.261),-- Changethis to change the loco of shop
        ["ped"] = 'a_m_y_soucent_01',
        ["scenario"] = "WORLD_HUMAN_CLIPBOARD",
        ["radius"] = 2.5,
        ["targetIcon"] = "fa-brands fa-pagelines",
        ["targetLabel"] = "Open Shop",
        ["products"] = Config.Products["flowersupplies"],
        ["showblip"] = true,---True on to show blips
        ["blipsprite"] = 489,--change if you want
        ["blipscale"] = 0.6,
        ["blipcolor"] = 1 
    },
```

**Add to qb-core/shared.lua**

*Add into QBShared.Items*
```
    	["scissors"]						= {["name"] = "scissors",       		    		["label"] = "Scissors",	 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "scissors.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Cut some flowers with this"},
["flower"] 		 	 	 		 = {["name"] = "flower", 					["label"] = "Rose Flower", 			["created"] = nil, 		["decay"] = 7.0,		["weight"] = 25, 		["type"] = "item", 		["image"] = "flower.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Rose Flower."},
	["flower_paper"] 		 	 	 = {["name"] = "flower_paper", 				["label"] = "Flower Paper", 		["created"] = nil, 		["decay"] = 7.0,		["weight"] = 10, 		["type"] = "item", 		["image"] = "flower_paper.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Flower Paper."},
	["flower_bulck"] 		 	 	 = {["name"] = "flower_bulck", 				["label"] = "Flower Bulck", 		["created"] = nil, 		["decay"] = 7.0,		["weight"] = 50, 		["type"] = "item", 		["image"] = "flower_bulck.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Flowers Bulck."},

```
 
 **Add Images into qb-inventory/html/images**
 
 
 
 
 
 **Dependencies**
 
 *By Default you should have these*
 
 qb-core: https://github.com/qbcore-framework/qb-core
 
 qb-inventory: https://github.com/qbcore-framework/qb-inventory
 
 qb-target: https://github.com/qbcore-framework/qb-target
 
 Progressbar: https://github.com/qbcore-framework/progressbar
 
 PolyZone: https://github.com/qbcore-framework/PolyZone
 

 
"# Flower-job" 
