SMODS.Atlas{ -- Jokers
    key = "nicjokers",
    path = "nicjokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Ijiraq Jokers
    key = "nicjokersijiraq",
    path = "ijiraq/nicjokersijiraq.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Teto Jokers
    key = "nictetojokers",
    path = "teto/nictetojokers.png",
    px = 71,
    py = 95,
}

-- Plants

SMODS.Atlas{ -- Plant Jokers
    key = "nicpvzjokers",
    path = "pvz/nicpvzjokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Plant Consumables
    key = "nicpvzconsumables",
    path = "pvz/nicpvzconsumables.png",
    px = 71,
    py = 95,
}

-- Scrapped

SMODS.Atlas{ -- Phases
    key = "nicphases",
    path = "scrapped/nicphases.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Placeholder
    key = "nicplaceholder",
    path = "scrapped/nicplaceholder.png",
    px = 71,
    py = 95,
}

-- Others

SMODS.Atlas{ -- Blinds
    key = "nicblinds",
    path = "nicblinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

SMODS.Atlas{ -- Boosters
    key = 'nicboosters',
    path = 'nicboosters.png',
    px = 71,
    py = 95,
}

SMODS.Atlas { -- Icon
  key = "modicon",
  px = 32,
  py = 32,
  path = "nicicon.png" 
}

SMODS.Atlas{ -- Partners
    key = "nicpartners",
    path = "nicpartners.png",
    px = 46,
    py = 58,
}

SMODS.Atlas{ -- Sticker
    key = "nicstickers",
    path = "nicstickers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Tarots
    key = "nictarots",
    path = "nictarots.png",
    px = 71,
    py = 95,
}

-- Music

--[[SMODS.Sound{ -- Black Knife
    key = "music_black_knife",
    path = "music/black_knife.ogg",
    select_music_track = function (self)
        return next(SMODS.find_card("j_nic_incognito")) and 1e10 or nil
    end,
    pitch = 1,
}]]

-- Sounds

SMODS.Sound{ -- Click
    key = "click",
    path = "click.ogg",
}

SMODS.Sound{ -- Dripstone
    key = "dripstone",
    path = "dripstone.ogg",
}

SMODS.Sound{ -- Duck
    key = "duck",
    path = "duck.ogg",
}

SMODS.Sound{ -- Explosion
    key = "explosion",
    path = "explosion.ogg",
}

SMODS.Sound{ -- Gambling
    key = "gambling",
    path = "gambling.ogg",
}

SMODS.Sound{ -- Machinedramon
    key = "machinedramon",
    path = "machinedramon.ogg",
}

SMODS.Sound{ -- Metal Gear Solid Alert
    key = "metalalert",
    path = "metalalert.ogg",
}

SMODS.Sound{ -- Neigh
    key = "neigh",
    path = "neigh.ogg",
}

SMODS.Sound{ -- Spamtonf1
    key = "spamtonf1",
    path = "spamtonf1.ogg",
}

SMODS.Sound{ -- Technoblade Never Dies
    key = "technoblade",
    path = "technoblade.ogg",
}

SMODS.Sound{ -- Teto Oh My God My Penis
    key = "tetoohmygodmypenis",
    path = "tetoohmygodmypenis.ogg",
}

SMODS.Sound{ -- Teto Word Of The Day
    key = "tetowordoftheday",
    path = "tetowordoftheday.ogg",
}

SMODS.Sound{ -- Win
    key = "win",
    path = "win.ogg",
}

SMODS.Sound{ -- XP Level Up
    key = "xplevelup",
    path = "xplevelup.ogg",
}

SMODS.Sound{ -- XP Orb
    key = "xporb",
    path = "xporb.ogg",
}

-- PVZ Sounds

SMODS.Sound{ -- Cherry Bomb
    key = "cherrybomb",
    path = "pvz/cherrybomb.ogg",
}

SMODS.Sound{ -- Chomper
    key = "chomper",
    path = "pvz/chomper.ogg",
}

SMODS.Sound{ -- Doom-shroom
    key = "doomshroom",
    path = "pvz/doomshroom.ogg",
}

SMODS.Sound{ -- Grave Buster
    key = "gravebuster",
    path = "pvz/gravebuster.ogg",
}

SMODS.Sound{ -- Hypno-shroom
    key = "hypnoshroom",
    path = "pvz/hypnoshroom.ogg",
}

SMODS.Sound{ -- Ice-shroom
    key = "iceshroom",
    path = "pvz/iceshroom.ogg",
}

SMODS.Sound{ -- Potato Mine
    key = "potatomine",
    path = "pvz/potatomine.ogg",
}

SMODS.Sound{ -- Shovel
    key = "shovel",
    path = "pvz/shovel.ogg",
}

SMODS.Sound{ -- Vase Break
    key = "vasebreak",
    path = "pvz/vasebreak.ogg",
}