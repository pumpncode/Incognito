-- Teto

SMODS.Joker{ -- Kasane Jokto
    key = "kasanejokto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 0, y = 0},
    config = { extra = { repetitions = 2 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:get_id() == 4 then
                return {
                    message = localize('k_again_ex'),
                    colour = HEX("e15d73"),
                    repetitions = card.ability.extra.repetitions
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
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 1, y = 0},
    config = { extra = { xmult = 1.5 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)        
        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            local other_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    if not other_card:is_suit("Hearts") then
                        other_card:juice_up()
                        play_sound('tarot2', 1.1, 0.6)
                    end
                    if other_card:is_suit("Clubs") then
                        other_card:change_suit('Diamonds')
                    elseif other_card:is_suit("Diamonds") then
                        other_card:change_suit('Spades')
                    elseif other_card:is_suit("Spades") then
                        other_card:change_suit('Hearts')    
                    end
                    return true
                end
            }))
            if not context.other_card:is_suit("Hearts") then
                return { message = "BLOOD!", colour = G.C.RED }
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
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 6,
    pos = {x = 2, y = 0},
    config = { extra = { levels = 1, pear = 5, pear_needed = 5, pear_loss = 1 } },
    pools = { Food = true, ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.pear, card.ability.extra.pear_needed } }
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
                    colour = HEX("e15d73")
                }
            else
                card.ability.extra.pear = card.ability.extra.pear - card.ability.extra.pear_loss
            end
        end

        if context.before and context.main_eval and context.scoring_name == "Pair" then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = "TETO PEAR!", 
                colour = HEX("e15d73")
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
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 7,
    pos = {x = 3, y = 0},
    config = { extra = { levels = 3, odds = 1000 } },
    pools = { Food = true, ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = { new_numerator, new_denominator, card.ability.extra.levels } }
    end,

    in_pool = function(self, args)
        return G.GAME.pool_flags.nic_pear_gone
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, ('j_nic_pearto'), 1, card.ability.extra.odds) then
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
                    message = "NOM :(",
                    colour = HEX("e15d73")
                }
            else
                return {
                    message = "SAFE :)",
                    colour = HEX("e15d73")
                }
            end
        end

        if context.before and context.main_eval and context.scoring_name == "Pair" then
            return {
                level_up = card.ability.extra.levels, level_up_hand = "Pair", 
                message = "TETO PEAR!", 
                colour = HEX("e15d73")
            }
        end
    end
}

SMODS.Joker{ -- Doctor Kidori
    key = "doctorkidori",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 4, y = 0},
    config = { extra = {} },
    pools = { ["Teto"] = true },
}

SMODS.Joker{ -- Birdbrain Teto
    key = "birdbrainteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 0, y = 1},
    config = { extra = { mult = 0, mult_gain = 5} },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.scoring_name == "Pair" then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            else
                card.ability.extra.mult = 0
                return {
                    message = "MY PENIS!",
                    colour = HEX("e15d73")
                }
            end
        end
        if context.joker_main and card.ability.extra.mult ~= 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Tenebre Rosso Sangue Teto
    key = "tenebrerossosangueteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 7,
    pos = {x = 1, y = 1},
    config = { extra = { dollars = 4 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local heart_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Hearts") then
                    heart_cards = heart_cards + 1
                end
            end
            if heart_cards > 0 then
                return {
                    message = "BLOOD RED RAIN!",
                    colour = HEX("e15d73"),
                    dollars = card.ability.extra.dollars * heart_cards
                }
            end
        end
    end
}

SMODS.Joker{ -- Spoken For Teto
    key = "spokenforteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 2, y = 1},
    config = { extra = { xmult = 2 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX('e15d73') }, card.ability.extra.xmult } }
    end, 

    calculate = function(self, card, context)
        if (context.other_consumeable and context.other_consumeable.config.center_key == "c_nic_tetotarot") or 
        (context.other_joker and (context.other_joker.config.center.rarity == "nic_teto" or context.other_joker.ability.nic_tetosticker)) then
            return {
                xmult = card.ability.extra.xmult,
                colour = HEX("e15d73")
            }
        end
    end,

}

SMODS.Joker{ -- Teto Word Of The Day
    key = "tetowordoftheday",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 3, y = 1},
    config = { extra = { teto = 0, teto_rounds = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX('e15d73') }, card.ability.extra.teto, card.ability.extra.teto_rounds } }
    end, 

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint and not context.retrigger_joker and (card.ability.extra.teto == card.ability.extra.teto_rounds) then
            if #G.jokers.cards <= G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = 'Joker', rarity = 'nic_teto' })
                        return true
                    end
                }))
                return { 
                    message = "TETO :D",
                    colour = HEX("e15d73") 
                }
            else
                return { 
                    message = "NO ROOM!",
                    colour = HEX("e15d73") 
                }
            end
        end
        if context.end_of_round and G.GAME.blind.boss and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.teto ~= card.ability.extra.teto_rounds then
                card.ability.extra.teto = card.ability.extra.teto + 1
                if card.ability.extra.teto == card.ability.extra.teto_rounds then
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                    play_sound("nic_tetowordoftheday")
                end
                return {
                    message = (card.ability.extra.teto < card.ability.extra.teto_rounds) and (card.ability.extra.teto .. '/' .. card.ability.extra.teto_rounds) or "TETO WORD OF THE DAY",
                    colour = HEX("e15d73") 
                }
            else
                return {
                    message = "ACTIVE!",
                    colour = HEX("e15d73") 
                }
            end
        end
    end
}

SMODS.Joker{ -- Mesmerizer Teto
    key = "mesmerizerteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 8,
    pos = {x = 4, y = 1},
    config = { extra = { repetitions = 2 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local compatible = G.jokers.cards[1] and G.jokers.cards[1] ~= card and
                (G.jokers.cards[1].config.center.rarity == "nic_teto" or G.jokers.cards[1].ability.nic_tetosticker) and G.jokers.cards[1].config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize { type = 'variable', key = (compatible and 'nic_tetoactive' or 'nic_tetoinactive') } .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { 
                vars = { colours = { HEX('e15d73') }, card.ability.extra.repetitions },
                main_end = main_end 
            }
        else
            return { 
                vars = { colours = { HEX('e15d73') }, card.ability.extra.repetitions } 
            }
        end
    end,

    calculate = function(self, card, context)
    	if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card == G.jokers.cards[1] and (G.jokers.cards[1].config.center.rarity == "nic_teto" or G.jokers.cards[1].ability.nic_tetosticker) and G.jokers.cards[1].config.center.blueprint_compat then
                return {
                    message = "MESMERIZED!",
                    colour = HEX("e15d73"),
                    repetitions = card.ability.extra.repetitions,
                }
            end
        end
    end
}

SMODS.Joker{ -- Spamteto 
    key = "spamteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 0, y = 2},
    config = { extra = { dollars = 30, dollars_final = 0, uses = 0 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_final } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars_final
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.uses = 1
            card.ability.extra.dollars_final = 0
        end

        if context.key_press_f1 then
            if context.blueprint and card.ability.extra.uses == 1 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("nic_spamtonf1")
                        ease_discard(pseudorandom("discard", 0, 1))
                        ease_hands_played(1)
                        return true
                    end
                }))
                return {
                    message = "[[BIG SHOT]]",
                    colour = HEX("e15d73")
                }
            else
                if card.ability.extra.uses == 1 or context.retrigger_joker then
                    card.ability.extra.uses = 0
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("nic_spamtonf1")
                            ease_discard(pseudorandom("discard", 0, 1))
                            ease_hands_played(1)
                            return true
                        end
                    }))
                    return {
                        message = "[[BIG SHOT]]",
                        colour = HEX("e15d73")
                    }
                end
            end
        end

        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.dollars_final = card.ability.extra.dollars_final + math.floor(G.GAME.dollars * (card.ability.extra.dollars/100))
            card.ability.extra.uses = 0
            return {
                message = ('[+$' .. card.ability.extra.dollars_final .. ']'),
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Joker{ -- Tetoris 
    key = "tetoris",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 1, y = 2},
    config = { extra = { hearts = 10, hearts_needed = 10, hearts_loss = 1 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hearts, card.ability.extra.hearts_needed } }
    end, 

    calculate = function(self, card, context)
        if context.joker_main then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then
                    if card.ability.extra.hearts <= 1 then
                        if not context.blueprint then
                            card.ability.extra.hearts = card.ability.extra.hearts_needed
                        end
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card({ set = 'Tarot', key = "c_sun" })
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            }))
                            return { message = ('TETORIS'), colour = HEX("e15d73") }
                        else
                            return { message = ('No Room :('), colour = HEX("e15d73") }
                        end
                    else
                        if not context.blueprint then
                            card.ability.extra.hearts = card.ability.extra.hearts - card.ability.extra.hearts_loss
                            return { message = "TETO", colour = HEX("e15d73") }
                        end
                    end
                end
            end
        end
    end
}

SMODS.Joker{ -- Minimum Rage Teto 
    key = "minimumrageteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 2, y = 2},
    config = { extra = { mult = 0 } },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end, 

    calculate = function(self, card, context)
        if (context.buying_card or context.nic_buying_booster) and not context.blueprint and context.card.cost > 0 then
            card.ability.extra.mult = card.ability.extra.mult + context.card.cost
            return { message = ("SMILE +" .. context.card.cost), colour = HEX("e15d73") }
        end

        if context.selling_card and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.mult = 0
            return { message = "FUCK THE COOPERATION", colour = HEX("e15d73") }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ -- Teto Territory
    key = "tetoterritory",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 3, y = 2},
    config = { extra = {} },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX('e15d73') } } }
    end, 

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            local teto_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].getting_sliced and G.jokers.cards[i].config.center.rarity ~= "nic_teto" and not G.jokers.cards[i].ability.nic_tetosticker then
                    teto_jokers[#teto_jokers + 1] = G.jokers.cards[i]
                end
            end
            local joker_to_teto = pseudorandom_element(teto_jokers, 'nic_tetoterritory')

            if joker_to_teto then
                if (joker_to_teto.config.center.pools or {}).Food then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            joker_to_teto:juice_up(0.5, 0.5)
                            play_sound('tarot2', 1.1, 0.6)
                            joker_to_teto:set_ability(G.P_CENTERS.j_nic_pear)
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            joker_to_teto:juice_up(0.5, 0.5)
                            play_sound('tarot2', 1.1, 0.6)
                            joker_to_teto:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Teto, 'teto').key)
                            return true
                        end
                    }))
                end
                return { message = "TERRITORY", colour = HEX("e15d73") }
            end
        end
    end
}

SMODS.Joker{ -- Contradictions Teto
    key = "contradictionsteto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nictetojokers',
    rarity = "nic_teto",
    cost = 5,
    pos = {x = 4, y = 2},
    config = { extra = {} },
    pools = { ["Teto"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end, 

    calculate = function(self, card, context)
        if context.after then
            for i = 1, #G.playing_cards do
                local other_card = G.playing_cards[i]
                if next(SMODS.get_enhancements(other_card)) and (other_card:is_suit("Hearts") or other_card.base.suit == "Hearts") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:juice_up()
                            play_sound('tarot1')
                            other_card:set_ability(SMODS.poll_enhancement { guaranteed = true }, nil, true)
                            return true
                        end
                    }))
                    delay(0.1)
                end
            end
            return {
                message = "CONTRADICTIONS",
                colour = HEX("e15d73")
            }
        end
    end
}