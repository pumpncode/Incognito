SMODS.Atlas{ -- Logo
    key = "niclogo",
    path = "niclogo.png",
    px = 333,
    py = 210,
}

-- Logo

Incognito.custom_ui = function(nodes)
    local logo = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = {0,0,0,0},
            r = 0.3,
            padding = 0.25
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = SMODS.create_sprite(
                                0, 0,
                                8, 5,
                                'nic_niclogo',
                                { x = 0, y = 0 }
                            )
                        }
                    }
                }
            }
        }
    }
    table.insert(nodes, 2, logo)
    return nodes
end

SMODS.current_mod.ui_config = {
    author_colour = G.C.NIC_INCOGNITO,
    tab_button_colour = G.C.NIC_INCOGNITO,
    back_colour = G.C.NIC_INCOGNITO,
    bg_colour = adjust_alpha(G.C.NIC_INVERT, 0.95),
    colour = darken(G.C.NIC_INVERT, .2),
    outline_colour = lighten(G.C.NIC_INVERT, .2),
}

-- Config

local old_config = copy_table(Incognito.config)
local function should_restart()
    for k, v in pairs(old_config) do
        if v ~= Incognito.config[k] then
            SMODS.full_restart = 1
            return
        end
    end
    SMODS.full_restart = 0
end

Incognito.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.07, emboss = 0.05, r = 0.1, colour = G.C.NIC_INVERT, minh = 4.5, minw = 7 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Requires restart!", colour = G.C.NIC_INCOGNITO, scale = 0.6 } },
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    {
                        n = G.UIT.C,
                        nodes = {
                            create_toggle({
                                label = "Scrapped Concepts [Mid]",
                                ref_table = Incognito.config,
                                ref_value = "scrapped_things",
                                callback = should_restart,
                            }),
                        },
                    },
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Doesn't need restart!", colour = G.C.NIC_INCOGNITO, scale = 0.6 } },
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    {
                        n = G.UIT.C,
                        nodes = {
                            create_toggle({
                                label = "THE ROARING INC?",
                                ref_table = Incognito.config,
                                ref_value = "roaring_inc",
                            }),
                        },
                    },
                },
            },
        },
    }
end