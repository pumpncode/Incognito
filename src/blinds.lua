SMODS.Atlas{ -- Blinds
    key = "nicblinds",
    path = "nicblinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

SMODS.Blind { -- Monarch
    key = "monarch",
    dollars = 5,
    mult = 2,
    debuff = { value = "King" },
    atlas = "nicblinds",
    pos = { x = 0, y = 0 },
    boss = { min = 6 },
    boss_colour = HEX("888888"),
}