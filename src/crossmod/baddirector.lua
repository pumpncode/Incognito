SMODS.Atlas{ -- Bad Director Jokers
    key = "nicbaddirector",
    path = "crossmod/nicbaddirector.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Niko Teto
    key = "tetoxko",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicbaddirector',
    rarity = "nic_teto",
    cost = 5,
    pos = { x = 1, y = 0 },
    soul_pos = {
        x = 0,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) *
                    math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            rotate_mod = 0.3 * math.sin(10 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            card.children.floating_sprite:draw_shader('dissolve',
                0, nil, nil, card.children.center, scale_mod, rotate_mod , nil, 0.1)
            card.children.floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    },
    config = { extra = { } },
    pools = { ["Teto"] = true },
    dependencies = { 'baddirector' },
}