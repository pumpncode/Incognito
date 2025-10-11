-- SCRAP

SMODS.Rarity{
	key = "scrapped",
	badge_colour = G.C.BLACK,
	default_weight = 0,
}

SMODS.Joker{ -- Transfer Chips
    key = "overflow",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'placeholder',
    rarity = "nic_scrapped",
    cost = 20,
    pos = {x = 0, y = 0},
    config = { extra = { leftovers = 0, chips = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.leftovers, card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.chips = (to_number(G.GAME.chips) - to_number(G.GAME.blind.chips))/2
            card.ability.extra.leftovers = to_number(G.GAME.chips) - to_number(G.GAME.blind.chips)
            return {
                message = "Yum"
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.after then
            card.ability.extra.chips = 0
        end
    end
}

SMODS.Joker{ -- Reroll Infinite
    key = "reroll",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'placeholder',
    rarity = "nic_scrapped",
    cost = 20,
    pos = {x = 0, y = 0},
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.shop.joker_max = G.GAME.shop.joker_max + 1
        if G.shop then
            G.shop:recalculate()
            G.shop_jokers.T.w = 3.2*G.CARD_W
        end
        SMODS.change_free_rerolls(2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.shop.joker_max = G.GAME.shop.joker_max - 1
        SMODS.change_free_rerolls(-2)
    end,

    calculate = function(self, card, context)
        if context.reroll_shop then
            G.GAME.current_round.free_rerolls = 2
        end
    end
}


SMODS.Joker{ -- The True Fibonacci Sequence
    key = "thetruefibonaccisequence",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'placeholder',
    rarity = "nic_scrapped",
    cost = 20,
    pos = {x = 0, y = 0},
    config = { extra = { xchips = 1, counter = 1, counter_gain = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then 
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
        end

        if context.joker_main then
            card.ability.extra.xchips = ((1/math.sqrt(5)) * (((1 + math.sqrt(5)) / 2)^(card.ability.extra.counter))) + ((-1/math.sqrt(5)) * (((1 - math.sqrt(5)) / 2)^(card.ability.extra.counter)))
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Consumable {
    discovered = true,
    key = 'newmoon',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 0, y = 0 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_waxingcrescent)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,

    use = function(self, card, area, copier)
        if G.booster_pack then 
            SMODS.add_card({ set = 'Spectral', key = "c_nic_newmoon" })
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return (G.booster_pack and #G.consumeables.cards < G.consumeables.config.card_limit and card.area == G.consumeables == false) or G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'waxingcrescent',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 1, y = 0 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_firstquarter)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'firstquarter',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 2, y = 0 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_waxinggibbous)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'waxinggibbous',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 3, y = 0 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_fullmoon)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'fullmoon',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 0, y = 1 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_waninggibbous)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'waninggibbous',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 1, y = 1 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_thirdquarter)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'thirdquarter',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 2, y = 1 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_waningscrescent)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

SMODS.Consumable {
    discovered = true,
    key = 'waningscrescent',
    set = 'Spectral',
    cost = 4,
    atlas = 'phases',
    pos = {x = 3, y = 1 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_moonphases", set = "Other" }
    end,

    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
				func = function()
                    card:juice_up(0.5, 0.5)
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.c_nic_newmoon)
					return true
				end
			}))
            return {
				message = "The Moon",
				colour = G.C.BLUE
			}
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
}

--[[   calculate = function(self, card, context) -- Hands are Pairs
        if G.jokers.cards[#G.jokers.cards] == card then
            if context.evaluate_poker_hand then
                return {
                    replace_scoring_name = "Pair"
                }
            end
        end
    end]]

--[[    card.ability.extra.mult = G.GAME.hands["Pair"].played * 10 -- Amount of Played and Level
            card.ability.extra.chips = to_number(G.GAME.hands["Pair"].level) * 50
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end]]
