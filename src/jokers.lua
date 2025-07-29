-- Common

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
    config = { extra = { xmult = 1.5, odds = 100, chance = 1} },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.key_press_space or (context.cry_press and card.states.hover.is == true) then
            if SMODS.pseudorandom_probability(card, ('j_nic_button'), 1, card.ability.extra.odds) then
                card:start_dissolve({G.C.RED})
                card:juice_up(10, 10)
                return { play_sound("nic_explosion"), message = "BOOM!", colour = G.C.RED }
            else
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

-- Uncommon

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
    config = { extra = { oldshopsize = 3, slycooper_remaining = 1, odds = 4 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = { 
            new_numerator, new_denominator,
            localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_active' or 'nic_inactive'), vars = { card.ability.extra.slycooper_remaining } }, 
            card.ability.extra.oldshopsize 
        } 
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.shop.joker_max = G.GAME.shop.joker_max + 1
        if G.shop then
            G.shop:recalculate()
            G.shop_jokers.T.w = 3.2*G.CARD_W
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = G.GAME.shop.joker_max - 1
	end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local eval = function(card) return card.ability.extra.slycooper_remaining == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
            card.ability.extra.slycooper_remaining = card.ability.extra.slycooper_remaining - 1
            return { message = "ACTIVE!", colour = G.C.RED }
        end
        if context.starting_shop then
            return { play_sound('nic_gambling') }
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

SMODS.Joker{ -- Crazy Taxi
    key = "crazytaxi",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 4, y = 0},
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
        card.ability.time = string.gsub(
            string.format("%.2f", 30 - (G.TIMERS.REAL - card.ability.start) * card.ability.inblind), "%.", ":")
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

SMODS.Joker{ -- Unlucky Cat
    key = "unluckycat",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 6,
    pos = {x = 5, y = 0},
    config = { extra = { xmult = 1, xmult_gain = 0.25} },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') and not context.other_card.lucky_trigger and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.xmult > 1 then
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
        
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Rare

SMODS.Joker{ -- Technoblade
    key = "technoblade",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 1},
    config = { extra = { mult = 0, chips = 0, scoreReq = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.scoreReq } }
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
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.mult = card.ability.extra.mult + sliced_card.sell_cost * 3
                        card.ability.extra.chips = card.ability.extra.chips + sliced_card.sell_cost * 4
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return { message = "THE BLADE", colour = G.C.RED }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round and context.game_over and context.main_eval then
            if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(card.ability.extra.scoreReq / 100) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('nic_technoblade')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = "TECHNOBLADE NEVER DIES!",
                    saved = 'ph_nic_technoblade',
                    colour = G.C.RED
                }
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
    pos = {x = 3, y = 1},
    config = { extra = { mult = 50, chips = 50 } },

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
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.mult * stone_tally, card.ability.extra.chips * stone_tally } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                card.ability.extra.chips = card.ability.extra.chips + 25
                card.ability.extra.mult = card.ability.extra.mult + 25
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

        if context.joker_main then
            local stone_tally = 0
            for k, v in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
            end
            return {
                mult = card.ability.extra.mult * stone_tally,
                chips = card.ability.extra.chips * stone_tally
            }
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
    pos = {x = 4, y = 1},
    config = { extra = { mult = 0, xmult = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.mult, card.ability.extra.xmult } }
    end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge('Mega', G.C.BLACK, G.C.WHITE, 0.5)
        badges[#badges+1] = create_badge('Virus', G.C.BLACK, G.C.WHITE, 0.5)
        badges[#badges+1] = create_badge('Machine', G.C.BLACK, G.C.WHITE, 0.5)
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and not context.blueprint and G.GAME.current_round.hands_left == 0 then
            if context.other_card then
			    local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        other_card:set_ability('m_steel')
                        play_sound("nic_machinedramon")
                        return true
                    end
                }))
            end
        end

        if context.individual and context.cardarea == G.play and not context.end_of_round and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                context.other_card.should_destroy = true
                card.ability.extra.mult = (card.ability.extra.mult) + 15
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                return { message = "ASSEMBLE!", colour = G.C.BLACK }
            end
        end

        if context.joker_main then
            local eval = function(card) return G.GAME.current_round.hands_left == 1 and not card.REMOVED end
            juice_card_until(card, eval, true)
            return { 
                mult = card.ability.extra.mult, 
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
    pos = {x = 2, y = 2},
    config = { extra = { levels = 1, levels_gain = 1, randomizer = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.levels_gain } }
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then 
            card.ability.extra.randomizer = pseudorandom('nic_humantorch', 1, 4)
        end

        if (context.cardarea == G.play or context.cardarea == "unscored") and not context.blueprint and context.destroy_card == context.full_hand[card.ability.extra.randomizer] and #context.full_hand == 4 then
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
    atlas = 'invisiblewoman',
    rarity = 3,
    cost = 8,
    pos = {x = 0, y = 0},
    config = { extra = { counter = 1, counter_gain = 1, randomizer = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.counter, card.ability.extra.counter_gain} }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then 
            card.ability.extra.randomizer = pseudorandom('nic_invisiblewoman', 1, 4)
        end

        if context.setting_blind and not context.blueprint then
            local eval = function(card) return G.GAME.current_round.hands_played == 0 and not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        if context.before and context.main_eval then
            local eval = function(card) return G.GAME.current_round.hands_left == 1 and not card.REMOVED end
            juice_card_until(card, eval, true)
            if context.scoring_name == "Four of a Kind" and #context.full_hand == 4 and #context.full_hand == 4 then
                if G.GAME.current_round.hands_left == 0 or next(SMODS.find_card("j_nic_misterfantastic")) then 
                    if next(SMODS.find_card("j_nic_misterfantastic")) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                for i = 1, card.ability.extra.counter do
                                    local copy_card = copy_card(context.full_hand[card.ability.extra.randomizer], nil, nil, G.playing_card)
                                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                                    table.insert(G.playing_cards, copy_card)
                                    copy_card:set_ability("m_glass", true)
                                    copy_card:start_materialize()
                                    G.hand:emplace(copy_card)
                                end
                                return true
                            end
                        }))
                    end
                    if not context.blueprint then
                        card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
                        return {
                            message = "NEVER SEE ME COMING",
                            colour = G.C.BLUE
                        }
                    end
                end
                if G.GAME.current_round.hands_played == 0 then
                    if not next(SMODS.find_card("j_nic_misterfantastic")) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                for i = 1, card.ability.extra.counter do
                                    local copy_card = copy_card(context.full_hand[card.ability.extra.randomizer], nil, nil, G.playing_card)
                                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                                    table.insert(G.playing_cards, copy_card)
                                    copy_card:set_ability("m_glass", true)
                                    copy_card:start_materialize()
                                    G.hand:emplace(copy_card)
                                end
                                return true
                            end
                        }))
                        return {
                            message = "DISAPPEAR",
                            colour = G.C.BLUE
                        }
                    end
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
    pos = {x = 4, y = 2},
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
    pos = {x = 5, y = 2},

    calculate = function(self, card, context)
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

-- Legendary

SMODS.Joker{ -- Cyan
    key = "cyan",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 0, y = 1},
    soul_pos = {x = 1, y = 1},
    config = { extra = { xchips = 1, counter = 1, counter_gain = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then 
            card.ability.extra.counter = card.ability.extra.counter + card.ability.extra.counter_gain
            card:juice_up(0.5, 0.5)
            return { play_sound("nic_neigh") }
        end

        if context.joker_main then
            card.ability.extra.xchips = ((1/math.sqrt(5)) * (((1 + math.sqrt(5)) / 2)^(card.ability.extra.counter))) + ((-1/math.sqrt(5)) * (((1 - math.sqrt(5)) / 2)^(card.ability.extra.counter)))
            return {
                xchips = card.ability.extra.xchips
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
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { extra = { xmult = 1, odds = 7 } },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return {vars = {new_numerator, new_denominator, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cry_press and card.states.hover.is == true then
            card.ability.extra.xmult = (card.ability.extra.xmult) + 1
        end
            
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if not (context.other_card:is_suit("Spades")) then
                if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "nic") then
                    if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), 1, card.ability.extra.odds) then
                        context.other_card.should_destroy = true
                        card.ability.extra.xmult = (card.ability.extra.xmult) * 2
                        return { message = "DOUBLE SWOON!", colour = HEX("d0d0d0") }
                    else
                        return { message = "SOWY :(", colour = G.C.BLACK }
                    end
                else
                    if SMODS.pseudorandom_probability(card, ('j_nic_incognito'), 1, card.ability.extra.odds) then
                        context.other_card.should_destroy = true
                        card.ability.extra.xmult = (card.ability.extra.xmult) + 1
                        return { message = "SWOON!", colour = HEX("d0d0d0") }
                    else
                        return { message = "NOPE!", colour = G.C.BLACK }
                    end
                end
            end
        end  

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "nic") then
                    return {
                        message = "HAI NIC!", 
                        colour = HEX("d0d0d0"),
                        xmult = card.ability.extra.xmult
                    }
                else
                    return {
                        message = "71!", 
                        colour = HEX("d0d0d0"),
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}

-- Dalgona

SMODS.Joker{ -- Dalgona Cookie
    key = "dalgonacookie",
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 2, y = 3},
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
                    card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Dalgona, 'dalgona').key)
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
    rarity = "nic_dalgona",
    cost = 0,
    pos = {x = 3, y = 3},
    config = { extra = { xmult = 1.5, xmult_gain = 0.25, min = 1, max = 2, randomizer = 1, price = 1, counter = 3 } },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult, 
            card.ability.extra.xmult_gain,
            card.ability.extra.min,
            card.ability.extra.max,
            card.ability.extra.randomizer,
            card.ability.extra.price,
            card.ability.extra.counter
        }
    }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.randomizer = pseudorandom('nic_dalgonacircle', card.ability.extra.min, card.ability.extra.max)
        end
        
        if context.individual and not context.blueprint then
            if context.cardarea == G.play then
                if card.ability.extra.xmult == card.ability.extra.min then
                    return {
                        message = "MIN",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                    return {
                        message = "-X0.25",
                        colour = G.C.MULT
                    }
                end
            end
            if context.cardarea == "unscored" then
                if card.ability.extra.xmult == card.ability.extra.max then
                    return {
                        message = "MAX",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        message = "+X0.25",
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.randomizer == card.ability.extra.xmult then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price 
                card:set_cost()
                return {
                    play_sound("nic_win"),
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.counter <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                        message = "FAILED",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.counter = card.ability.extra.counter - 1
                    return {
                        message = "CRACK...",
                        colour = G.C.RED
                    }
                end
            end
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
    rarity = "nic_dalgona",
    cost = 0,
    pos = {x = 4, y = 3},
    config = { extra = { xmult = 1.5, xmult_gain = 0.25, min = 1, max = 3, randomizer = 1, price = 2, counter = 3 } },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult, 
            card.ability.extra.xmult_gain,
            card.ability.extra.min,
            card.ability.extra.max,
            card.ability.extra.randomizer,
            card.ability.extra.price,
            card.ability.extra.counter
        }
    }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.randomizer = pseudorandom('nic_dalgonatriangle', card.ability.extra.min, card.ability.extra.max)
        end
        
        if context.individual and not context.blueprint then
            if context.cardarea == G.play then
                if card.ability.extra.xmult == card.ability.extra.min then
                    return {
                        message = "MIN",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                    return {
                        message = "-X0.25",
                        colour = G.C.MULT
                    }
                end
            end
            if context.cardarea == "unscored" then
                if card.ability.extra.xmult == card.ability.extra.max then
                    return {
                        message = "MAX",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        message = "+X0.25",
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.randomizer == card.ability.extra.xmult then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price 
                card:set_cost()
                return {
                    play_sound("nic_win"),
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.counter <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                        message = "FAILED",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.counter = card.ability.extra.counter - 1
                    return {
                        message = "CRACK...",
                        colour = G.C.RED
                    }
                end
            end
        end
    end
}

SMODS.Joker{ -- Dalgona Star
    key = "dalgonastar",
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = "nic_dalgona",
    cost = 0,
    pos = {x = 5, y = 3},
    config = { extra = { xmult = 1.5, xmult_gain = 0.25, min = 1, max = 5, randomizer = 1, price = 3, counter = 3 } },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult, 
            card.ability.extra.xmult_gain,
            card.ability.extra.min,
            card.ability.extra.max,
            card.ability.extra.randomizer,
            card.ability.extra.price,
            card.ability.extra.counter
        }
    }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.randomizer = pseudorandom('nic_dalgonastar', card.ability.extra.min, card.ability.extra.max)
        end
        
        if context.individual and not context.blueprint then
            if context.cardarea == G.play then
                if card.ability.extra.xmult == card.ability.extra.min then
                    return {
                        message = "MIN",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                    return {
                        message = "-X0.25",
                        colour = G.C.MULT
                    }
                end
            end
            if context.cardarea == "unscored" then
                if card.ability.extra.xmult == card.ability.extra.max then
                    return {
                        message = "MAX",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        message = "+X0.25",
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.randomizer == card.ability.extra.xmult then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price 
                card:set_cost()
                return {
                    play_sound("nic_win"),
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.counter <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                        message = "FAILED",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.counter = card.ability.extra.counter - 1
                    return {
                        message = "CRACK...",
                        colour = G.C.RED
                    }
                end
            end
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
    rarity = "nic_dalgona",
    cost = 0,
    pos = {x = 6, y = 3},
    config = { extra = { xmult = 1.5, xmult_gain = 0.25, min = 1, max = 8, randomizer = 1, price = 5, counter = 3 } },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult, 
            card.ability.extra.xmult_gain,
            card.ability.extra.min,
            card.ability.extra.max,
            card.ability.extra.randomizer,
            card.ability.extra.price,
            card.ability.extra.counter
        }
    }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.randomizer = pseudorandom('nic_dalgonacircle', card.ability.extra.min, card.ability.extra.max)
        end
        
        if context.individual and not context.blueprint then
            if context.cardarea == G.play then
                if card.ability.extra.xmult == card.ability.extra.min then
                    return {
                        message = "MIN",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                    return {
                        message = "-X0.25",
                        colour = G.C.MULT
                    }
                end
            end
            if context.cardarea == "unscored" then
                if card.ability.extra.xmult == card.ability.extra.max then
                    return {
                        message = "MAX",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        message = "+X0.25",
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.randomizer == card.ability.extra.xmult then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price 
                card:set_cost()
                return {
                    play_sound("nic_win"),
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            else
                if card.ability.extra.counter <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                        message = "FAILED",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.counter = card.ability.extra.counter - 1
                    return {
                        message = "CRACK...",
                        colour = G.C.RED
                    }
                end
            end
        end
    end
}

-- Teto

SMODS.Joker{ -- Kasane Jokto
    key = "kasanejokto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 2, y = 4},
    config = { extra = { repetitions = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    set_badges = function(self, card, badges)
        badges[#badges] = create_badge('Teto', HEX('e15d73'), G.C.WHITE, 1.2)
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:get_id() == 4 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker{ -- Ambassador Teto
    key = "ambassadorteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 7,
    pos = {x = 3, y = 4},
    config = { extra = { xmult = 1.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    set_badges = function(self, card, badges)
        badges[#badges] = create_badge('Teto', HEX('e15d73'), G.C.WHITE, 1.2)
    end,

    calculate = function(self, card, context)        
        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if context.other_card:is_suit("Clubs") then
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        other_card:change_suit('Diamonds')
                        return true
                    end
                }))
            end
            if context.other_card:is_suit("Diamonds") then
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        other_card:change_suit('Spades')
                        return true
                    end
                }))
            end
            if context.other_card:is_suit("Spades") then
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        other_card:change_suit('Hearts')
                        return true
                    end
                }))
            end
            if not context.other_card:is_suit("Hearts") then
                return { message = "BLOOD!", colour = G.C.RED }
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Hearts") then
                if context.other_card:get_id() == 4 then
                    return {
                        xmult = card.ability.extra.xmult + 1.5
                    }
                else
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}

SMODS.Joker{ -- Pear
    key = "pear",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 6,
    pos = {x = 4, y = 4},
    config = { extra = { levels = 2, pear = 5, pear_loss = 1 } },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.pear, card.ability.extra.pear_loss} }
    end,

    set_badges = function(self, card, badges)
        badges[#badges] = create_badge('Teto', HEX('e15d73'), G.C.WHITE, 1.2)
    end,

    calculate = function(self, card, context)
        if context.after and context.main_eval and not context.blueprint and context.scoring_name == "Pair" then
            if card.ability.extra.pear - card.ability.extra.pear_loss <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                G.GAME.pool_flags.nic_pear_gone = true
                return {
                    message = "NOM :(",
                    colour = G.C.RED
                }
            else
                card.ability.extra.pear = card.ability.extra.pear - card.ability.extra.pear_loss
            end
        end

        if context.before and context.main_eval and context.scoring_name == "Pair" then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = "TETO PEAR!", 
                colour = G.C.RED
            }
        end
    end
}

SMODS.Joker{ -- Pearto
    key = "pearto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 7,
    pos = {x = 5, y = 4},
    config = { extra = { levels = 3, mult = 0, chips = 0 } },
    pools = { Food = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.mult, card.ability.extra.chips } }
    end,

    set_badges = function(self, card, badges)
        badges[#badges] = create_badge('Teto', HEX('e15d73'), G.C.WHITE, 1.2)
    end,

    in_pool = function(self, args)
        return G.GAME.pool_flags.nic_pear_gone
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and context.scoring_name == "Pair" then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = "TETO PEAR!", 
                colour = G.C.RED
            }
        end

        if context.joker_main then
            card.ability.extra.mult = G.GAME.hands["Pair"].played * 10
            card.ability.extra.chips = to_number(G.GAME.hands["Pair"].level) * 50
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker{ -- Doctor Kidori
    key = "doctorkidori",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 0, y = 4},
    soul_pos = {x = 1, y = 4},
    config = { extra = { xmult = 2, doctorkidori_right = 1 } },

    loc_vars = function(self, info_queue, card)
    if G.jokers and card.area == G.jokers then 
        local compatible = G.jokers.cards[#G.jokers.cards]
    end

        return { vars = { card.ability.extra.xmult } }
    end,

    set_badges = function(self, card, badges)
        badges[#badges] = create_badge('Teto', HEX('e15d73'), G.C.WHITE, 1.2)
    end,

    calculate = function(self, card, context)
        if G.jokers.cards[#G.jokers.cards] == card then
            if context.evaluate_poker_hand then
                return {
                    replace_scoring_name = "Pair"
                }
            end
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.perma_mult <= 0 then 
                context.other_card.ability.perma_mult = 1
            end
            if context.other_card.ability.perma_bonus <= 0 then 
                context.other_card.ability.perma_bonus = 1
            end
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult * 2
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus * 2
            if context.other_card:get_id() == 4 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
} 

-- SCRAP

SMODS.Joker{ -- Transfer overscore
    key = "test",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'placeholder',
    rarity = 2,
    cost = 6,
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

--[[SMODS.Joker{ -- Pot of Greed
    key = "potofgreed",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'potofgreedjoke',
    rarity = 1,
    cost = 1,
    pos = {x = 0, y = 0},
    config = { extra = { mult = 4 } },

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            card:start_dissolve({G.C.RED})
            for i=1, 2 do
                local copy = copy_card(card)
                copy:add_to_deck()
                copy.ability.extra_value = -copy.cost
                card.area:emplace(copy)
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}]]

--[[SMODS.Joker{ -- Reroll Gimmick
    key = "yup",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 10,
    pos = {x = 3, y = 0},

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-2)
    end,

    calculate = function(self, card, context)
        if context.reroll_shop then
            G.GAME.current_round.free_rerolls = 2
        end
    end
}]]