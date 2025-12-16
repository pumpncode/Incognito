SMODS.Consumable {
    key = 'tetotarot',
    set = 'Tarot',
    cost = 4,
    atlas = 'nictarots',
    pos = {x = 0, y = 0 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_tetosticker", set = "Other" }
        return { vars = { colours = { HEX('e15d73') }} }
    end, 

    use = function(self, card, area, copier)
        if (G.jokers.highlighted[1].config.center.pools or {}).Food then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.jokers.highlighted[1]:juice_up()
                    G.jokers.highlighted[1]:set_ability(G.P_CENTERS.j_nic_pear)
                    play_sound('gold_seal', 1.2, 0.4)
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.6,
                func = function() 
                    G.jokers.highlighted[1]:juice_up()
                    G.jokers.highlighted[1]:add_sticker("nic_tetosticker", true)
                    play_sound('gold_seal', 1.2, 0.4)
                    G.jokers:unhighlight_all()
                    return true 
                end 
            }))
        end
    end,

    can_use = function (self, card) 
        return #G.jokers.highlighted > 0 and G.jokers.highlighted[1].config.center.rarity ~= "nic_teto" and not G.jokers.highlighted[1].ability.nic_tetosticker
    end,
}