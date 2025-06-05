------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("mirtin_arena",src)
vSERVER = Tunnel.getInterface("mirtin_arena")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config = {}
config.rangeDistance = 350 -- Distancia se o player se afastar muito voltar para a arena

config.locArenas = { -- Localizações das arenas
    vec3(-1649.7,-1091.01,13.15),
    vec3(183.13,-900.74,30.54),
    vec3(-93.38,6354.0,31.58),
}

config.keys = {
    scoreboard = 52, -- Q
    spawn = 38, -- SPAWNAR
}

config.drawMarker = function(coords) -- DRAWMARKER DO BLIP DA ARENA
    DrawMarker(0,coords,0,0,0,0,0,130.0, 0.5,0.5,0.5, 12,198,254,180 ,1,0,0,1)
end

config.drawTxt = function()
    drawTxt("VOCÊ ESTÁ MORTO PRESSIONE ~b~E~w~ PARA SPAWNAR",4,0.5,0.93,0.50,255,255,255,255)
end

--[[ -- COLOQUE ISSO NAS FUNCOES DE CLIENTS
    local in_arena = false

    RegisterNetEvent("mirtin_survival:updateArena")
    AddEventHandler("mirtin_survival:updateArena", function(boolean)
        in_arena = boolean
    end)
]] 



Attachments = {
    [`WEAPON_GLOCK`] = {
        "COMPONENT_SLIDE_04",
        "COMPONENT_SUPP_01",
        "COMPONENT_CLIP_04",
        "COMPONENT_GLOCK_FLSH_01",
	},

	[`WEAPON_AKM`] = {
        "COMPONENT_AKM_STOCK_02",
        "COMPONENT_AKM_CLIP_02",
        "COMPONENT_AKM_DUSTCOVER_04",
        "COMPONENT_AKM_SCOPE_02",
        "COMPONENT_AKM_PISTOLGRIP_01",
        "COMPONENT_AKM_HANDGUARD_04",
        "COMPONENT_AKM_SUPP_01",
	},

	[`WEAPON_SR25`] = {
        "COMPONENT_SR25_SCOPE_03",
        "COMPONENT_SR25_FLSH_02",
        "COMPONENT_SR25_CLIP_03",
	},

	[`WEAPON_AR15`] = {
        "COMPONENT_AR15_CLIP_09",
	},

	[`WEAPON_50BEOWULF`] = {
        "COMPONENT_BEOWULF_CLIP_09",
        "COMPONENT_BEOWULF_GRIP_02",
        "COMPONENT_BEOWULF_SCOPE_10",
        "COMPONENT_BEOWULF_BODY_05",
        "COMPONENT_BEOWULF_SUPP_02",
        "COMPONENT_BEOWULF_FLSH_01",
	},

	[`WEAPON_PISTOL`] = {
        "COMPONENT_PISTOL_CLIP_02",
        "COMPONENT_AT_PI_FLSH",
	},
	
	[`WEAPON_PISTOL_MK2`] = {
        "COMPONENT_AT_PI_FLSH_02",
        "COMPONENT_AT_PI_COMP",
        "COMPONENT_AT_PI_RAIL",
	},

	[`WEAPON_REVOLVER`] = {
        "COMPONENT_AT_PI_FLSH_02",
        "COMPONENT_AT_PI_COMP",
        "COMPONENT_AT_PI_RAIL",
	},
	
	[`WEAPON_CERAMICPISTOL`] = {
        "COMPONENT_CERAMICPISTOL_CLIP_02",
	},
	
	[`WEAPON_COMBATPISTOL`] = {
        "COMPONENT_COMBATPISTOL_CLIP_02",
        "COMPONENT_AT_PI_FLSH",
	},
	
	[`WEAPON_SMG`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO_02",
	},
	
	[`WEAPON_SMG_MK2`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_PI_SUPP",
        "COMPONENT_AT_SIGHTS_SMG",
	},
	
	[`WEAPON_MINISMG`] = {
        "COMPONENT_MINISMG_CLIP_02",
	},
	
	[`WEAPON_MICROSMG`] = {
        "COMPONENT_AT_PI_FLSH",
        "COMPONENT_AT_SCOPE_MACRO",
	},
	
	[`WEAPON_COMBATPDW`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_SMALL",
        "COMPONENT_AT_AR_AFGRIP",
	},

	[`WEAPON_MACHINEPISTOL`] = {
        "COMPONENT_AT_PI_SUPP",
        "COMPONENT_MACHINEPISTOL_CLIP_02",
	},
	
	[`WEAPON_ASSAULTSMG`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO",
	},
	
	[`WEAPON_COMBATMG`] = {
        "COMPONENT_COMBATMG_CLIP_02",
        "COMPONENT_AT_SCOPE_MEDIUM",
        "COMPONENT_AT_AR_AFGRIP",
	},
	
	[`WEAPON_ASSAULTRIFLE`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO",
        "COMPONENT_AT_AR_AFGRIP",
	},
	
	[`WEAPON_ASSAULTRIFLE_MK2`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM_MK2",
        "COMPONENT_AT_AR_AFGRIP_01",
	},

    [`WEAPON_M9A3`] = {
    "COMPONENT_AT_PI_FLSH",
    "COMPONENT_AT_PI_SUPP_02",
    },

    [`WEAPON_MP9`] = {
    "COMPONENT_MP9_CLIP_02",
    "COMPONENT_MP9_AT_SCOPE_MACRO",
    "COMPONENT_MP9_AT_AR_SUPP_02"
    },

    [`WEAPON_NAVYCARBINE`] = {
    "COMPONENT_NAVYCARBINE_SIGHT_01",
    },

    [`WEAPON_NSR`] = {
    "COMPONENT_NSR_AT_AR_SUPP",
    "COMPONENT_NSR_AT_AR_FLSH"
    },

    [`WEAPON_SCARH`] = {
    -- "COMPONENT_SCARH_CLIP_02",
    "COMPONENT_SCARH_AT_AR_FLSH",
    "COMPONENT_SCARH_AT_SCOPE_MEDIUM",
    "COMPONENT_SCARH_AT_SCOPE_MACRO",
    "COMPONENT_AT_AR_SUPP_02",
    "COMPONENT_AT_AR_AFGRIP",
    },

    [`WEAPON_SCORPIONEVO`] = {
    "COMPONENT_SCORPIONEVO_CLIP_02 ",
    },
    
    [`WEAPON_PARAFAL`] = {
    },
    
    [`WEAPON_MP5K`] = {
    },
	
	[`WEAPON_CARBINERIFLE`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_MUZZLE_04",
        "COMPONENT_AT_SIGHTS",
        "COMPONENT_AT_AR_AFGRIP_02",
	},
	
	[`WEAPON_CARBINERIFLE_MK2`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_MUZZLE_04",
        "COMPONENT_AT_SIGHTS",
        "COMPONENT_AT_AR_AFGRIP_02",
	},
	
	[`WEAPON_ADVANCEDRIFLE`] = {
        "COMPONENT_ADVANCEDRIFLE_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_SMALL",
	},
	
	[`WEAPON_MILITARYRIFLE`] = {
        "COMPONENT_MILITARYRIFLE_CLIP_01",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_SMALL",
	},
	
	[`WEAPON_COMPACTRIFLE`] = {
        "COMPONENT_COMPACTRIFLE_CLIP_02",
	},
	[`WEAPON_SPECIALCARBINE`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM",
	},
	[`WEAPON_SPECIALCARBINE_MK2`] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM_MK2",
        "COMPONENT_AT_MUZZLE_01",
	},
}