SMODS.Atlas{ -- Partners
    key = "nicpartners",
    path = "crossmod/nicpartners.png",
    px = 46,
    py = 58,
}

Partner_API.Partner{
    key = "incognito",
    unlocked = true,
    discovered = true,
    atlas = 'nicpartners',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { extra = { mult = 10, odds = 7 } },
    link_config = {j_nic_incognito = 1},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        return {vars = {new_numerator, new_denominator, card.ability.extra.mult*benefits}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Spades") then
            if SMODS.pseudorandom_probability(card, ('pnr_nic_incognito'), 1, card.ability.extra.odds) then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 2 end
                return {
                    mult = card.ability.extra.mult*benefits
                }
            else
                return { message = "NOPE!", colour = G.C.SUITS.Spades }
            end
        end
    end
}

Partner_API.Partner{
    key = "invert",
    unlocked = true,
    discovered = true,
    atlas = 'nicpartners',
    pos = {x = 2, y = 0},
    soul_pos = {x = 3, y = 0},
    config = { extra = { handsize = 0, handsize_gain = 1, odds = 7 } },
    link_config = {j_nic_invert = 1},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        return {vars = {new_numerator, new_denominator, card.ability.extra.handsize, card.ability.extra.handsize_gain*benefits}}
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval then
            if SMODS.pseudorandom_probability(card, ('pnr_nic_incognito'), 1, card.ability.extra.odds) then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 2 end
                card.ability.extra.handsize = card.ability.extra.handsize + card.ability.extra.handsize_gain*benefits
                G.hand:change_size(card.ability.extra.handsize_gain)
                return { message = "HAHAHA!", colour = G.C.DARK_EDITION }
            else
                return { message = "NOPE!", colour = G.C.DARK_EDITION }
            end
        end
    end
}

Partner_API.Partner{
    key = "pear",
    unlocked = true,
    discovered = true,
    atlas = 'nicpartners',
    pos = {x = 4, y = 0},
    config = { extra = { levels = 1, pear = 5, pear_needed = 5, pear_loss = 1 } },
    link_config = {j_nic_pear = 1},

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.pear, card.ability.extra.pear_needed } }
    end,

    calculate = function(self, card, context)
        local link_level = self:get_link_level()
        if link_level == 1 then
            if card.ability.extra.pear > 3 then
                card.ability.extra.pear = 3
            end
            card.ability.extra.pear_needed = 3
        else
            card.ability.extra.pear_needed = 5
        end

        if context.before and context.main_eval and context.scoring_name == "Pair" then
            if card.ability.extra.pear - card.ability.extra.pear_loss <= 0 then
                card.ability.extra.pear = card.ability.extra.pear_needed
                return {
                    level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                    message = "TETO PEAR!", 
                    colour = HEX("e15d73")
                }
            else
                card.ability.extra.pear = card.ability.extra.pear - card.ability.extra.pear_loss
                return {
                    message = (card.ability.extra.pear .. '/' .. card.ability.extra.pear_needed),
                    colour = HEX("e15d73")
                }
            end
        end
    end
}

Partner_API.Partner{
    key = "pearto",
    unlocked = true,
    discovered = true,
    atlas = 'nicpartners',
    pos = {x = 0, y = 1},
    config = { extra = { levels = 3, odds = 3 } },
    link_config = {j_nic_pearto = 1},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        local link_level = self:get_link_level()
        local benefits = 0
        if link_level == 1 then benefits = 1 end
        return {vars = {new_numerator, new_denominator-benefits, card.ability.extra.levels}}
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and context.scoring_name == "Pair" then
            local link_level = self:get_link_level()
            local benefits = 0
            if link_level == 1 then benefits = 1 end
            if SMODS.pseudorandom_probability(card, ('pnr_nic_incognito'), 1, card.ability.extra.odds-benefits) then
                return {
                    level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                    message = "TETO PEAR!", 
                    colour = HEX("e15d73")
                }
            else
                return {
                    message = "NOPE! :(", 
                    colour = HEX("e15d73")
                }
            end
        end
    end
}