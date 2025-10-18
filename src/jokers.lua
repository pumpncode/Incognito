SMODS.Joker{ -- Technoblade
    key = "technoblade",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 0},
    config = { extra = { score = 25, prevent = 3, prevent_needed = 3, prevent_loss = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.prevent, card.ability.extra.prevent_needed, card.ability.extra.score } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(card.ability.extra.score / 100) then
                if card.ability.extra.prevent <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('nic_technoblade')
                            card:start_dissolve()
                            return true
                        end
                    }))
                else
                    card.ability.extra.prevent = card.ability.extra.prevent - card.ability.extra.prevent_loss
                    card.ability.extra.score = card.ability.extra.score + 25  
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('nic_technoblade')
                            return true
                        end
                    }))
                end
                return {
                    message = (card.ability.extra.prevent > 1) and (card.ability.extra.prevent .. '/' .. card.ability.extra.prevent_needed) or "TECHNOBLADE NEVER DIES!",
                    saved = 'ph_nic_technoblade',
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{ -- Machinedramon
    key = "machinedramon",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 0},
    config = { extra = { mult = 0, xmult = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.mult, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and not context.blueprint and context.end_of_round then
            if context.other_card then
			    local other_card = context.other_card
                if not next(SMODS.get_enhancements(other_card)) and not other_card.debuff then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            other_card:juice_up()
                            other_card:set_ability('m_steel')
                            play_sound("nic_machinedramon")
                            return true
                        end
                    }))
                end
            end
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                context.other_card.should_destroy = true
                card.ability.extra.mult = (card.ability.extra.mult) + 15
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                return { message = "ASSEMBLE!", colour = G.C.BLACK }
            end
        end

        if context.joker_main then
            return { 
                mult = card.ability.extra.mult, 
                xmult = card.ability.extra.xmult 
            }
        end
	end
}

SMODS.Joker{ -- Button
    key = "button",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 3,
    pos = {x = 2, y = 0 },
    config = { extra = { xmult = 0.5, min = 1, max = 1000, odds = 1 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.min, card.ability.extra.max) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.key_press_space or (context.cry_press and card.states.hover.is == true) then
            if SMODS.pseudorandom_probability(card, ('j_nic_button'), card.ability.extra.min, card.ability.extra.max) then
                card:start_dissolve({G.C.RED})
                card:juice_up(10, 10)
                return { play_sound("nic_explosion"), message = "BOOM!", colour = G.C.RED }
            else
                card.ability.extra.odds = pseudorandom('j_nic_buttonodds', 1, 5)
                card.ability.extra.min = card.ability.extra.min + card.ability.extra.odds
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.05
                card:juice_up(0.5, 0.5)
                return { play_sound("nic_click") }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult 
            }
        end
    end
}

SMODS.Joker{ -- Sly Cooper
    key = "slycooper",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 3, y = 0},
    config = { extra = { slycooper_remaining = 1, odds = 4 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = {
            new_numerator, new_denominator,
            localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_active' or 'nic_inactive'), vars = { card.ability.extra.slycooper_remaining } }, 
        } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local eval = function(card) return card.ability.extra.slycooper_remaining == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
            card.ability.extra.slycooper_remaining = 0
            return { message = "ACTIVE!", colour = G.C.RED }
        end
        if context.starting_shop and not context.blueprint then
            return { play_sound('nic_gambling') }
        end
        if context.ending_shop and not context.blueprint then
            card.ability.extra.slycooper_remaining = 1
        end

        if card.ability.extra.slycooper_remaining == 0 then
            if (context.buying_card or context.nic_buying_booster or context.nic_buying_voucher) and context.card.cost > 0 then
                card.ability.extra.slycooper_remaining = card.ability.extra.slycooper_remaining + 1
                if SMODS.pseudorandom_probability(card, ('j_nic_slycooper'), 1, card.ability.extra.odds) then
                    context.card.cost = context.card.cost * 2
                    SMODS.calculate_effect({
                        message = 'CAUGHT!',
                        colour = G.C.RED,
                        play_sound('nic_metalalert'),
                    },context.card)
                else 
                    context.card.cost = 0
                    SMODS.calculate_effect({
                        message = 'SNATCH!',
                        colour = G.C.GREEN,
                    },context.card)
                end
            end
        end
    end
}

SMODS.Joker{ -- Stalagmite
    key = "stalagmite",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 4, y = 0},
    config = { extra = { chips = 50, chips_gain = 50 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local stone_tally = 0
        if G.hand then
            if G.hand.cards then
                for k, v in ipairs(G.hand.cards) do
                    if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
                end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.chips * stone_tally } }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                if context.other_card.edition and context.other_card.edition.negative == true then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                    context.other_card.should_destroy = true
                    return {
                        message = "Impaled",
                        colour = G.C.CHIPS
                    }
                else
                    local other_card = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:juice_up()
                            other_card:set_edition('e_negative', nil, true)
                            play_sound("nic_dripstone")
                            return true
                        end
                    }))
                end
            end
        end

        if context.joker_main then
            local stone_tally = 0
            for k, v in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips * stone_tally
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Cookie
    key = "dalgonacookie",
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 5, y = 0},
    config = { extra = {} },
    pools = { Food = true },

    loc_vars = function(self, info_queue, center)
		return { vars = {} }
	end,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot2', 1.1, 0.6)
                    card:juice_up()
                    card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Dalgona, 'dalgona', {in_pool = function() return true end}).key)
                    return true
                end
            }))
        end
    end
}

SMODS.ObjectType{ -- Pool Dalgona
	key = "Dalgona",
	cards = {
        ['j_nic_dalgonacircle'] = true,
        ['j_nic_dalgonatriangle'] = true,
        ['j_nic_dalgonastar'] = true,
        ['j_nic_dalgonaumbrella'] = true,
    }
}

SMODS.Joker{ -- Dalgona Circle
    key = "dalgonacircle",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 6, y = 0},
    config = { extra = { mult = 0, mult_gain = 3, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "High Card" or context.scoring_name == "Pair" or context.scoring_name == "Two Pair" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Triangle
    key = "dalgonatriangle",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 7, y = 0},
    config = { extra = { mult = 0, mult_gain = 10, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Three of a Kind" or context.scoring_name == "Straight" or context.scoring_name == "Flush" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Star
    key = "dalgonastar",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 8, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 0.25, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Full House" or context.scoring_name == "Four of a Kind" or context.scoring_name == "Straight Flush" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ -- Dalgona Umbrella
    key = "dalgonaumbrella",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 0,
    pos = {x = 9, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 1, success = 0, cookie = 3, cookie_needed = 3, cookie_loss = 1 } },
    pools = { Food = true },

    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.cookie, card.ability.extra.cookie_needed } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Five of a Kind" or context.scoring_name == "Flush House" or context.scoring_name == "Flush Five" then
                card.ability.extra.success = 1
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.success == 1 then 
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.cookie - card.ability.extra.cookie_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "FAILED!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.cookie = card.ability.extra.cookie - card.ability.extra.cookie_loss
                    return {
                        message = "CRACKED...",
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ -- Human Torch
    key = "humantorch",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 1},
    config = { extra = { levels = 1, levels_gain = 1, randomizer = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.levels_gain } }
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then 
            card.ability.extra.randomizer = pseudorandom('nic_humantorch', 1, 4)
        end

        if context.cardarea == G.play and not context.blueprint and context.destroy_card == context.full_hand[card.ability.extra.randomizer] and #context.full_hand == 4 then
            if context.scoring_name == "Four of a Kind" then
                return {
                    remove = true
                }
            end
        end
        if context.before and context.main_eval then
            local eval = function(card) return G.GAME.current_round.hands_left == 1 and not card.REMOVED end
            juice_card_until(card, eval, true)
            if context.scoring_name == "Four of a Kind" and #context.full_hand == 4 then
                if (G.GAME.current_round.hands_left == 0 or next(SMODS.find_card("j_nic_misterfantastic"))) then 
                    card.ability.extra.levels = card.ability.extra.levels + card.ability.extra.levels_gain
                    return {
                        level_up = card.ability.extra.levels, level_up_hand = "Four of a Kind", 
                        message = "TIME TO LIGHT IT UP",
                        colour = G.C.BLUE
                    }
                else
                    return {
                        level_up = card.ability.extra.levels, level_up_hand = "Four of a Kind", 
                        message = "FLAME ON",
                        colour = G.C.BLUE,
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --  Invisible Woman
    key = "invisiblewoman",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 1},
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        if context.mod_probability and not context.blueprint and context.identifier == "glass" then
			return {
				denominator = 2
			}
        end

        if context.before and context.main_eval and not context.blueprint then
            if context.scoring_name == "Four of a Kind" and #context.full_hand == 4 and #context.full_hand == 4 then
                if G.GAME.current_round.hands_played == 0 or next(SMODS.find_card("j_nic_misterfantastic")) then 
                    for _, other_card in ipairs(context.scoring_hand) do
                        other_card:set_ability('m_glass', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                other_card:juice_up()
                                return true
                            end
                        }))
                    end
                    return {
                        message = "DISAPPEAR",
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end


}

SMODS.Joker{ -- The Thing
    key = "thething",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 1},
    config = { extra = { counter = 1, counter_gain = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.counter, card.ability.extra.counter_gain } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            if not context.blueprint then
                local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, card.ability.extra.counter do
                        local stone_card = SMODS.create_card { set = "Base", enhancement = "m_stone", seal = SMODS.poll_seal({ guaranteed = true }), area = G.discard }
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        stone_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, stone_card)
                        
                        stone_card:start_materialize()
                        G.play:emplace(stone_card)
                        draw_card(G.play, G.deck, 90, 'up')
                    end
                    return true
                end
            }))
            return {
                message = "TIS THE CLOBBERIN HOUR",
                colour = G.C.BLUE
            }
        end
        if context.before and context.scoring_name == "Four of a Kind" and (G.GAME.current_round.hands_played == 0 or next(SMODS.find_card("j_nic_misterfantastic"))) and #context.full_hand == 4 and not context.blueprint then
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
            return {
                message = "CLOBBERIN' TIME",
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker{ -- Mister Fantastic
    key = "misterfantastic",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 3, y = 1},

    calculate = function(self, card, context)
        if context.modify_scoring_hand and not context.blueprint and #context.full_hand == 4 then
            return {
                add_to_hand = true
            }
        end

        if context.scoring_name and not context.blueprint and #context.full_hand == 4 then
            if context.evaluate_poker_hand then
                return {
                    replace_scoring_name = "Four of a Kind"
                }
            end
        end
        if context.before and context.main_eval and context.scoring_name == "Four of a Kind" and #context.full_hand == 4 and not context.blueprint then
            return {
                message = "FANTASTIC",
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker{ -- Incognito
    key = "incognito",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 4, y = 1},
    soul_pos = {x = 5, y = 1},
    config = { extra = { xmult = 1, xmult_gain = 1 , odds = 7 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "nic_spades_no_debuff", set = "Other" }
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult_gain, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true, colour = HEX("d0d0d0") }
        end

        if context.remove_playing_cards and not context.blueprint then
            local spades_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if not (removed_card.base.suit == "Spades") then
                    spades_cards = spades_cards + 1
                end
            end
            if spades_cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + (spades_cards * card.ability.extra.xmult_gain)
                return {
                    message = "+X" .. spades_cards .. " MULT!",
                    colour = HEX("d0d0d0"),
                }
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if not (context.other_card.base.suit == "Spades") then
                if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), 1, card.ability.extra.odds) then
                    context.other_card.should_destroy = true
                    return { message = "SWOON!", colour = HEX("d0d0d0") }
                else
                    return { message = "NOPE!", colour = HEX("d0d0d0") }
                end
            end
        end  

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker{ -- Crazy Taxi
    key = "crazytaxi",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 1},
    config = { start = 0, inblind = 0, time = 30, extra = { dollars = 1 } },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.dollars,
                localize((G.GAME.current_round.nic_crazytaxi_card or {}).rank or 'Ace', 'ranks')
            },
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.3 },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.ability,
                                ref_value = "time",
                                scale = 0.32,
                                colour = G.C.MONEY
                            }
                        }
                    }
                }
            }
        }
    end,

    update = function(self, card)
        local time = 30 - (G.TIMERS.REAL - card.ability.start) * card.ability.inblind
        if time <= 0 then
            card.ability.time = "0:00"
        else
            card.ability.time = string.gsub(string.format("%.2f", time), "%.", ":")
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    calculate = function(self, card, context)
        if context.blueprint then return end
        if context.setting_blind then
            card.ability.start = G.TIMERS.REAL
			card.ability.inblind = 1
            return {
                message = "TAKE ME TO THE NEXT ROUND"
            }
        end

        if context.individual and context.cardarea == G.play and
        context.other_card:get_id() == G.GAME.current_round.nic_crazytaxi_card.id then
            if (G.TIMERS.REAL - card.ability.start <= 30) then
                card.ability.start = card.ability.start + 5
                return {
                    message = "+5 Seconds"
                }
            else
                return {
                    message = "YOU'RE LATE"
                }
            end
        end
        
        if (context.end_of_round and context.main_eval and not context.repetition) or context.forcetrigger then
			card.ability.inblind = 0
			if (G.TIMERS.REAL - card.ability.start <= 30) or context.forcetrigger then
                card.ability.extra.dollars = card.ability.extra.dollars + 3
				return {
                    message = "THANK YOU",
                    play_sound('nic_win')
                }
            else
                card:start_dissolve()
                return {
                    message = "Failure",
                    play_sound('nic_explosion')
                }
			end
        end
    end
}

SMODS.Joker{ -- Strawberry Cake
    key = "strawberrycake",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 7, y = 1},
    config = { extra = { mult = 2 } },
    pools = { Food = true },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end
        if context.individual and not context.blueprint and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
            if not context.other_card:is_suit("Hearts") then
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        play_sound('tarot1')
                        other_card:change_suit('Hearts')
                        return true
                    end
                }))
                return {
                    message = "Love <3",
                    colour = G.C.SUITS.Hearts
                }
            end
        end
        if context.individual and context.cardarea == G.play and next(context.poker_hands['Flush']) and not G.GAME.current_round.hands_played == 0 then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = "+Mult <3",
                colour = G.C.SUITS.Hearts
            }
        end
    end
}


SMODS.Joker{ -- Ratio Technique
    key = "ratiotechnique",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 8, y = 1},
    config = { extra = { ratio = 0, ratio_display = "Nothing", rank = "" } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ratio_display, card.ability.extra.rank } }
    end,

    calculate = function(self, card, context)
        if not context.blueprint then 
            if ((((#G.hand.cards - #G.hand.highlighted ) * (0.70)) * 10) % 10 ) <= 4 then 
                card.ability.extra.ratio = math.floor((#G.hand.cards - #G.hand.highlighted ) * (0.70))
            else
                card.ability.extra.ratio = math.ceil((#G.hand.cards - #G.hand.highlighted ) * (0.70))
            end
            if card.ability.extra.ratio == 0 then
                card.ability.extra.ratio_display = "Nothing"
                card.ability.extra.rank = ""
            end
            if (card.ability.extra.ratio % 10) ~= 0 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "th Card"
            end
            if (card.ability.extra.ratio % 10) == 1 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "st Card"
            end
            if (card.ability.extra.ratio % 10) == 2 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "nd Card"
            end
            if (card.ability.extra.ratio % 10) == 3 and (math.floor(card.ability.extra.ratio / 10) % 10) ~= 1 then
                card.ability.extra.ratio_display = card.ability.extra.ratio
                card.ability.extra.rank = "rd Card"
            end
        end

        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and context.other_card == G.hand.cards[card.ability.extra.ratio] and not context.end_of_round and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                local other_card = context.other_card
                context.other_card.should_destroy = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = "|-|-|-|-|-|-o-|-|-|",
                    colour = G.C.RED
                }
            end
        end
    end
}   

SMODS.Joker{ -- Inverted Spear of Heaven
    key = "invertedspearofheaven",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 9, y = 1},
    config = { extra = { xmult = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end

            if my_pos and G.jokers.cards[my_pos - 1] and not G.jokers.cards[my_pos - 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos - 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.xmult = card.ability.extra.xmult + 0.5
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("4a157d") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.xmult = card.ability.extra.xmult + 0.5
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("4a157d") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            if G.GAME.blind.boss then
                if my_pos and G.jokers.cards[my_pos - 1] and my_pos and G.jokers.cards[my_pos + 1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            return true
                        end
                    }))
                    return { message = "FOCUS UP", colour = HEX("4a157d") }
                end
            else
                if my_pos and G.jokers.cards[my_pos - 1] or  G.jokers.cards[my_pos + 1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            return true
                        end
                    }))
                    return { message = "THIS IS WAR", colour = HEX("4a157d") }
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
}

SMODS.Joker{ -- Cyan
    key = "cyan",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 2},
    soul_pos = {x = 1, y = 2},
    config = { extra = { blind = 1.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind } }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.blind.chips = math.floor(to_number(G.GAME.blind.chips) * card.ability.extra.blind)
                G.GAME.blind.chip_text = G.GAME.blind.chips
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('nic_neigh')
                        SMODS.add_card({ set = 'Spectral', key = "c_black_hole" })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = ('X' .. card.ability.extra.blind ),
                }
            else
                return {
                    message = ('No Room :('),
                }
            end
        end
    end
}

SMODS.Joker { -- Inc
    key = "inc",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 3,
    pos = {x = 2, y = 2},
}

SMODS.Joker { -- Invert
    key = "invert",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 3,
    pos = {x = 3, y = 2},
}

SMODS.Joker { -- Astromancer
    key = "astromancer",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 4, y = 2},

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ set = 'Planet' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = "+1 Planet",
                colour = G.C.SECONDARY_SET.Planet
            }
        end
    end,
}

SMODS.Joker { -- Cartonomer
    key = "cartonomer",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 8,
    pos = {x = 5, y = 2},

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    if next(SMODS.find_card("j_nic_cartonomer")) then
        if (self.ability.set == 'Tarot' or (self.ability.set == 'Booster' and self.config.center.kind == 'Arcana')) then self.cost = 0 end
        self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    end
end

SMODS.Joker{ -- Tierlist
    key = "tierlist",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 2},
    config = { extra = { mult = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            local first_card = false
            for i = 1, #context.scoring_hand do
                if not SMODS.Ranks[context.scoring_hand[i].base.value].face and context.scoring_hand[i]:get_id() ~= 14 and not SMODS.has_no_rank(context.scoring_hand[i]) then
                    first_card = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            local last_card = false
            for i = #context.scoring_hand, 1, -1 do
                if not SMODS.Ranks[context.scoring_hand[i].base.value].face and context.scoring_hand[i]:get_id() ~= 14 and not SMODS.has_no_rank(context.scoring_hand[i]) then
                    last_card = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if first_card and last_card then
                return {
                    message = ("+" .. context.other_card.base.id .. " Mult"),
                    colour = G.C.MULT,
                    extra = {
                        message = ("-" .. context.other_card.base.id .. " Mult"),
                        colour = G.C.MULT
                    }
                }
            end
            if first_card then
                card.ability.extra.mult = card.ability.extra.mult + context.other_card.base.id 
                return {
                    message = ("+" .. context.other_card.base.id .. " Mult"),
                    colour = G.C.MULT
                }
            end
            if last_card then
                card.ability.extra.mult = card.ability.extra.mult - context.other_card.base.id 
                return {
                    message = ("-" .. context.other_card.base.id .. " Mult"),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Scenario
    key = "scenario",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 7, y = 2},
    config = { extra = { rarity = "Common" } },

    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('hologram', nil, card.ARGS.send_to_shader)
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { G.C.RARITY[card.ability.extra.rarity] }, localize('k_' .. card.ability.extra.rarity:lower()) } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local has_rarity = false 
            if G.jokers then
                for _, joker_card in ipairs(G.jokers.cards) do
                    if joker_card ~= card and joker_card:is_rarity(card.ability.extra.rarity) then
                        has_rarity = true
                        break
                    end
                end
            end
            if has_rarity then
                card.ability.extra.rarity = (pseudorandom_element(SMODS.Rarities, 'nic_scenario').key)
                card.ability.extra.dollars = 5
                return {
                    message = "SUCCESS!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.dollars = 0
                return {
                    message = "FAILED!",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker { -- Mending
    key = "mending",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 10,
    pos = {x = 8, y = 2},

    calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed then
            for i = 1, #context.removed do
                local repair_card = copy_card(context.removed[i], nil, nil, G.playing_card)
                table.insert(G.playing_cards, repair_card)
                G.discard:emplace(repair_card)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    if #context.removed == 1 then
                        play_sound("nic_xporb", 0.96 + math.random() * 0.08)
                        card:juice_up(0.5, 0.5)
                    else
                        play_sound("nic_xplevelup", 0.96 + math.random() * 0.08)
                        card:juice_up(0.5, 0.5)
                    end
                    return true
                end
            }))
        end
    end
}

SMODS.Joker { -- Calligram Joker
    key = "calligramjoker",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 9, y = 2},
    config = { extra = { mult = 1 } },

    loc_vars = function(self, info_queue, card)
        local my_pos = nil
        local letter_count = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
        end
        if my_pos and G.jokers.cards[my_pos - 1] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos - 1].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local letters = joker_name:sub(i,i)
                    if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                    letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
        if my_pos and G.jokers.cards[my_pos + 1] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos + 1].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local letters = joker_name:sub(i,i)
                    if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                    letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
        return { vars = { card.ability.extra.mult, letter_count * card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            local letter_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos - 1] then
                local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos - 1].config.center.key].name
                if joker_name then
                    for i = 1, #joker_name do
                        local letters = joker_name:sub(i,i)
                        if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                        letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                            letter_count = letter_count + 1
                        end
                    end
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[my_pos + 1].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local letters = joker_name:sub(i,i)
                    if letters == "j" or letters == "o" or letters == "k" or letters == "e" or letters == "r" or 
                    letters == "J" or letters == "O" or letters == "K" or letters == "E" or letters == "R" then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
            return {
                mult = letter_count * card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Clover Pit
    key = "cloverpit",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 0, y = 3},
    config = { extra = { dollars_loss = 1, min = -5 , max = 10, mult = 0 } },

    loc_vars = function(self, info_queue, card)
        local symbol = "+"
        if card.ability.extra.mult < 0 then
            symbol = ""
        else
            symbol = "+"
        end
        return { vars = { card.ability.extra.dollars_loss, card.ability.extra.min, card.ability.extra.max, symbol, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if (context.key_press_space or (context.cry_press and card.states.hover.is == true)) and (G.GAME.dollars > (card.ability.extra.dollars_loss - 1)) then
            ease_dollars(-card.ability.extra.dollars_loss, true)
            card.ability.extra.mult = pseudorandom('j_nic_cloverpit', card.ability.extra.min, card.ability.extra.max)
            card:juice_up(0.5, 0.5)
            return {
                message = "LETS GO GAMBLING!",
                colour = G.C.RED
            }
        end
        if context.end_of_round and G.GAME.blind.boss and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.dollars_loss = card.ability.extra.dollars_loss * 2
            card.ability.extra.min = card.ability.extra.min * 2
            card.ability.extra.max = card.ability.extra.max * 2
            card.ability.extra.mult = 0
            return {
                message = "LEVEL UP!",
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Cuphead
    key = "cuphead",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 1, y = 3},
    pixel_size = { h = 95 / 1.2 },
}