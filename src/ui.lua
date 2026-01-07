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
        config = { align = "cm", padding = 0.07, emboss = 0.05, r = 0.1, colour = G.C.BLACK, minh = 4.5, minw = 7 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.6 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Requires restart!", colour = G.C.RED, scale = 0.6 } },
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    {
                        n = G.UIT.C,
                        nodes = {
                            create_toggle({
                                label = "  Scrapped Concepts [Mid]",
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
                nodes = {
                    {
                        n = G.UIT.C,
                        nodes = {
                            create_toggle({
                                label = "     THE ROARING INC?",
                                ref_table = Incognito.config,
                                ref_value = "roaring_inc",
                                callback = should_restart,
                            }),
                        },
                    },
                },
            },
        },
    }
end