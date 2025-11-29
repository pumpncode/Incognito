local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand

jd_def["j_nic_technoblade"] = {
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "prevent" },
        { text = ")" },
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        local blind_ratio = to_big(G.GAME.chips / G.GAME.blind.chips)
        card.joker_display_values.prevent = (card.ability.extra.prevent .. '/' .. card.ability.extra.prevent_needed)
        card.joker_display_values.active = G.GAME and G.GAME.chips and G.GAME.blind.chips and blind_ratio and blind_ratio ~= to_big(0) and blind_ratio >= to_big(card.ability.extra.score / 100) and localize("jdis_active") or localize("jdis_inactive")
    end
}

jd_def["j_nic_machinedramon"] = {
    text = {
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
        { text = " " },
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            }
        },
    },
}

jd_def["j_nic_button"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            }
        },
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_nic_slycooper"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        card.joker_display_values.active = localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_stalagmite"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local stone_tally = 0
        for k, v in ipairs(G.hand.cards) do
            if playing_hand or not v.highlighted then
                if not (v.facing == 'back') and not v.debuff and SMODS.has_enhancement(v, 'm_stone') then
                    stone_tally = stone_tally + JokerDisplay.calculate_card_triggers(v, nil, true)
                end
            end
        end
        card.joker_display_values.chips = card.ability.extra.chips * stone_tally
    end
}

jd_def["j_nic_dalgona"] = {
}

jd_def["j_nic_dalgonacircle"] = {
    text = {
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "cookie" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.FILTER },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (card.ability.extra.success == 1 and 'nic_moneyactive' or 'nic_moneyinactive') }
        card.joker_display_values.cookie = (card.ability.extra.cookie .. '/' .. card.ability.extra.cookie_needed)
    end
}

jd_def["j_nic_dalgonatriangle"] = {
    text = {
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "cookie" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.FILTER },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (card.ability.extra.success == 1 and 'nic_moneyactive' or 'nic_moneyinactive') }
        card.joker_display_values.cookie = (card.ability.extra.cookie .. '/' .. card.ability.extra.cookie_needed)
    end
}

jd_def["j_nic_dalgonastar"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            }
        },
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "cookie" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.FILTER },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (card.ability.extra.success == 1 and 'nic_moneyactive' or 'nic_moneyinactive') }
        card.joker_display_values.cookie = (card.ability.extra.cookie .. '/' .. card.ability.extra.cookie_needed)
    end
}

jd_def["j_nic_dalgonaumbrella"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            }
        },
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "cookie" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.FILTER },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (card.ability.extra.success == 1 and 'nic_moneyactive' or 'nic_moneyinactive') }
        card.joker_display_values.cookie = (card.ability.extra.cookie .. '/' .. card.ability.extra.cookie_needed)
    end
}

jd_def["j_nic_humantorch"] = {
    text = {
        { ref_table = "card.ability.extra", ref_value = "levels" },
        { text = " Levels" },
    },
    text_config = { colour = G.C.BLUE },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (G.GAME.current_round.hands_played == 0 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_invisiblewoman"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (G.GAME.current_round.hands_played == 0 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_thething"] = {
    text = {
        { ref_table = "card.ability.extra", ref_value = "counter" },
        { text = " Stones" },
    },
    text_config = { colour = G.C.BLUE },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (G.GAME.current_round.hands_played == 0 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_misterfantastic"] = {
}

jd_def["j_nic_incognito"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
            }
        },
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local spades_cards = 0
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        for k, v in ipairs(G.hand.cards) do
            if playing_hand or not v.highlighted then
                if not (v.facing == 'back') and not v.debuff and v.base.suit and v.base.suit == "Spades" then
                    spades_cards = spades_cards + JokerDisplay.calculate_card_triggers(v, nil, true)
                end
            end
        end
        card.joker_display_values.xmult = card.ability.extra.xmult ^ spades_cards
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_nic_crazytaxi"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "dollars" },
    },
    text_config = { colour = G.C.GOLD },
    extra = {
        {
            { ref_table = "card.ability", ref_value = "time", retrigger_type = "mult" }
        }
    },
    extra_config = { colour = G.C.FILTER, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "crazytaxi_card", colour = G.C.FILTER },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.crazytaxi_card = localize(G.GAME.current_round.nic_crazytaxi_card.rank, 'ranks')
    end
}

jd_def["j_nic_strawberrycake"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (G.GAME.current_round.hands_played == 0 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_ratiotechnique"] = {
    text = {
        { ref_table = "card.ability.extra", ref_value = "ratio_display" },
        { ref_table = "card.ability.extra", ref_value = "rank" },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize { type = 'variable', key = (G.GAME.current_round.hands_played == 0 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_invertedspearofheaven"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            }
        },
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "active_text" },
    },
    calc_function = function(card)
        card.joker_display_values.active_text = localize(card.ability.extra.bossblind == 1 and 'k_active' or 'ph_no_boss_active')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[1] then
            reminder_text.children[1].config.colour = card.ability.extra.bossblind == 1 and G.C.GREEN or G.C.RED
            reminder_text.children[1].config.scale = card.ability.extra.bossblind == 1 and 0.35 or 0.3
            return true
        end
        return false
    end
}

jd_def["j_nic_cyan"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "blind" },
            },
            border_colour = G.C.FILTER
        },
    },
}

jd_def["j_nic_astromancer"] = {
}

jd_def["j_nic_cartonomer"] = {
}

jd_def["j_nic_tierlist"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
}

jd_def["j_nic_scenario"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "rarity" },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.FILTER },
        { text = ")" },
    },
    calc_function = function(card)
        local has_rarity = false 
        if G.jokers then
            for _, joker_card in ipairs(G.jokers.cards) do
                if joker_card ~= card and joker_card:is_rarity(card.ability.extra.rarity) then
                    has_rarity = true
                    break
                end
            end
        end
        card.joker_display_values.rarity = localize('k_' .. card.ability.extra.rarity:lower())
        card.joker_display_values.active = localize { type = 'variable', key = (has_rarity and 'nic_moneyactive' or 'nic_moneyinactive') }
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] then
            text.children[1].config.colour = G.C.RARITY[card.ability.extra.rarity]
            return true
        end
        return false
    end
}

jd_def["j_nic_mending"] = {
}

jd_def["j_nic_calligramjoker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "letter_count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
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
        card.joker_display_values.letter_count = letter_count
    end
}

jd_def["j_nic_cloverpit"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "symbol" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        if card.ability.extra.mult < 0 then
            card.joker_display_values.symbol = ""
        else
            card.joker_display_values.symbol = "+"
        end
    end
}

jd_def["j_nic_cuphead"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "card1" },
        { text = " " },
        { ref_table = "card.joker_display_values", ref_value = "card2" },
        { text = " " },
        { ref_table = "card.joker_display_values", ref_value = "card3" },
        { text = " " },
        { ref_table = "card.joker_display_values", ref_value = "card4" },
        { text = " " },
        { ref_table = "card.joker_display_values", ref_value = "card5" },
    },
    calc_function = function(card)
        if card.ability.extra.parry > 0 then card.joker_display_values.card1 = "[]" else card.joker_display_values.card1 = "*" end
        if card.ability.extra.parry > 1 then card.joker_display_values.card2 = "[]" else card.joker_display_values.card2 = "*" end
        if card.ability.extra.parry > 2 then card.joker_display_values.card3 = "[]" else card.joker_display_values.card3 = "*" end
        if card.ability.extra.parry > 3 then card.joker_display_values.card4 = "[]" else card.joker_display_values.card4 = "*" end
        if card.ability.extra.parry > 4 then card.joker_display_values.card5 = "[]" else card.joker_display_values.card5 = "*" end
        local heart = false
        local notheart = false
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if scoring_hand[i]:is_suit("Hearts") then
                    heart = true
                end
                if not scoring_hand[i]:is_suit("Hearts") then
                    notheart = true
                end
            end
        end
        if heart == false and notheart == true then
            if card.ability.extra.parry == 5 then
                mult = 5
            elseif card.ability.extra.parry > 0 then
                mult = 1
            end
        end
        card.joker_display_values.mult = card.ability.extra.mult * (mult)
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[1] and reminder_text.children[3] and reminder_text.children[5] and reminder_text.children[7] and reminder_text.children[9] then
            if card.ability.extra.parry > 0 then reminder_text.children[1].config.colour = G.C.SUITS.Hearts else reminder_text.children[1].config.colour = G.C.UI.TEXT_INACTIVE end
            if card.ability.extra.parry > 1 then reminder_text.children[3].config.colour = G.C.SUITS.Hearts else reminder_text.children[3].config.colour = G.C.UI.TEXT_INACTIVE end
            if card.ability.extra.parry > 2 then reminder_text.children[5].config.colour = G.C.SUITS.Hearts else reminder_text.children[5].config.colour = G.C.UI.TEXT_INACTIVE end
            if card.ability.extra.parry > 3 then reminder_text.children[7].config.colour = G.C.SUITS.Hearts else reminder_text.children[7].config.colour = G.C.UI.TEXT_INACTIVE end
            if card.ability.extra.parry > 4 then reminder_text.children[9].config.colour = G.C.SUITS.Hearts else reminder_text.children[9].config.colour = G.C.UI.TEXT_INACTIVE end
            return true
        end
        return false
    end
}

jd_def["j_nic_jokrle"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "[" },
        { ref_table = "card.joker_display_values", ref_value = "letter1" },
        { text = "]" },
        { text = " " },
        { text = "[" },
        { ref_table = "card.joker_display_values", ref_value = "letter2" },
        { text = "]" },
        { text = " " },
        { text = "[" },
        { ref_table = "card.joker_display_values", ref_value = "letter3" },
        { text = "]" },
        { text = " " },
        { text = "[" },
        { ref_table = "card.joker_display_values", ref_value = "letter4" },
        { text = "]" },
        { text = " " },
        { text = "[" },
        { ref_table = "card.joker_display_values", ref_value = "letter5" },
        { text = "]" },
    },
    calc_function = function(card)
        if card.ability.extra.tries == 0 then
            card.joker_display_values.letter1 = "#"
            card.joker_display_values.letter2 = "#"
            card.joker_display_values.letter3 = "#"
            card.joker_display_values.letter4 = "#"
            card.joker_display_values.letter5 = "#"
        else
            card.joker_display_values.letter1 = card.ability.extra.lines[card.ability.extra.tries][1]
            card.joker_display_values.letter2 = card.ability.extra.lines[card.ability.extra.tries][2]
            card.joker_display_values.letter3 = card.ability.extra.lines[card.ability.extra.tries][3]
            card.joker_display_values.letter4 = card.ability.extra.lines[card.ability.extra.tries][4]
            card.joker_display_values.letter5 = card.ability.extra.lines[card.ability.extra.tries][5]
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and 
        reminder_text.children[1] and reminder_text.children[2] and reminder_text.children[3] and 
        reminder_text.children[5] and reminder_text.children[6] and reminder_text.children[7] and 
        reminder_text.children[9] and reminder_text.children[10] and reminder_text.children[11] and 
        reminder_text.children[13] and reminder_text.children[14] and reminder_text.children[15] and 
        reminder_text.children[17] and reminder_text.children[18] and reminder_text.children[19] then 
            if card.ability.extra.tries == 0 then
                reminder_text.children[1].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[2].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[3].config.colour = HEX(card.ability.extra.grey)

                reminder_text.children[5].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[6].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[7].config.colour = HEX(card.ability.extra.grey)

                reminder_text.children[9].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[10].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[11].config.colour = HEX(card.ability.extra.grey)

                reminder_text.children[13].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[14].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[15].config.colour = HEX(card.ability.extra.grey)

                reminder_text.children[17].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[18].config.colour = HEX(card.ability.extra.grey)
                reminder_text.children[19].config.colour = HEX(card.ability.extra.grey)
            else
                reminder_text.children[1].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][1])
                reminder_text.children[2].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][1])
                reminder_text.children[3].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][1])

                reminder_text.children[5].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][2])
                reminder_text.children[6].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][2])
                reminder_text.children[7].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][2])

                reminder_text.children[9].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][3])
                reminder_text.children[10].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][3])
                reminder_text.children[11].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][3])

                reminder_text.children[13].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][4])
                reminder_text.children[14].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][4])
                reminder_text.children[15].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][4])

                reminder_text.children[17].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][5])
                reminder_text.children[18].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][5])
                reminder_text.children[19].config.colour = HEX(card.ability.extra.linescolour[card.ability.extra.tries][5])
            end
            return true
        end
        return false
    end
}

jd_def["j_nic_invert"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "handsize" },
    },
    text_config = { colour = G.C.FILTER },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_nic_solareclipse"] = {
    text = {
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
        { text = " " },
        { text = "+", colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
    },
}

-- Teto

jd_def["j_nic_kasanejokto"] = {
    reminder_text = {
        { text = "(4)" },
    },
}

jd_def["j_nic_ambassadorteto"] = {
}

jd_def["j_nic_pear"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "pear" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.pear = (card.ability.extra.pear .. '/' .. card.ability.extra.pear_needed)
    end
}

jd_def["j_nic_pearto"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_nic_doctorkidori"] = {
    reminder_text = {
        { text = "(4)" },
    },
}

jd_def["j_nic_birdbrainteto"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
}

jd_def["j_nic_tenebrerossosangueteto"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "dollars" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { text = "(" },
        { text = "Hearts", colour = G.C.SUITS.Hearts },
        { text = ")" }
    },
}

jd_def["j_nic_spokenforteto"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "count", colour = G.C.FILTER },
        { text = "x" },
        { text = "Teto", colour = HEX("e15d73") },
        { text = ")" },
    },
    calc_function = function(card)
        local count = 0
        if G.jokers then
            for _, joker_card in ipairs(G.jokers.cards) do
                if joker_card.config.center.rarity and joker_card.config.center.rarity == "nic_teto" then
                    count = count + 1
                end
            end
            for _, joker_card in ipairs(G.jokers.cards) do
                if joker_card.ability and joker_card.ability.nic_tetosticker then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.count = count
    end,
    mod_function = function(card, mod_joker)
        return { xmult = ((card.config.center.rarity == "nic_teto" or card.ability.nic_tetosticker) and mod_joker.ability.extra.xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
    end
}

jd_def["j_nic_tetowordoftheday"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "teto" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.teto = (card.ability.extra.teto .. '/' .. card.ability.extra.teto_rounds)
    end
}

jd_def["j_nic_mesmerizerteto"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        local compatible = G.jokers.cards[1] and G.jokers.cards[1] ~= card and 
        (G.jokers.cards[1].config.center.rarity == "nic_teto" or G.jokers.cards[1].ability.nic_tetosticker) and G.jokers.cards[1].config.center.blueprint_compat
        card.joker_display_values.active = localize { type = 'variable', key = (compatible and 'nic_tetoactive' or 'nic_tetoinactive') }
    end,
    style_function = function(card, text, reminder_text, extra)
        local compatible = G.jokers.cards[1] and G.jokers.cards[1] ~= card and 
        (G.jokers.cards[1].config.center.rarity == "nic_teto" or G.jokers.cards[1].ability.nic_tetosticker) and G.jokers.cards[1].config.center.blueprint_compat
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = compatible and G.C.GREEN or G.C.RED
            reminder_text.children[2].config.scale = compatible and 0.35 or 0.3
            return true
        end
        return false
    end
}

jd_def["j_nic_spamteto"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.money = math.floor(G.GAME.dollars * (card.ability.extra.dollars/100))
        card.joker_display_values.active = localize { type = 'variable', key = (card.ability.extra.uses == 1 and 'nic_active' or 'nic_inactive') }
    end
}

jd_def["j_nic_tetoris"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "hearts" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.hearts = (card.ability.extra.hearts .. '/' .. card.ability.extra.hearts_needed)
    end
}

jd_def["j_nic_minimumrageteto"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
}

jd_def["j_nic_tetoterritory"] = {
}

jd_def["j_nic_contradictionsteto"] = {
}