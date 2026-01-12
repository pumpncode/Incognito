SMODS.Atlas{ -- MoreFluff Jokers
    key = "nicmorefluff",
    path = "crossmod/morefluff/nicmorefluff.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Triangle Teto
    key = "triteto",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicmorefluff',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 1, y = 0},
    soul_pos = {x = 0, y = 0},
    config = { extra = {} },
    pools = { ["Teto"] = true },
}