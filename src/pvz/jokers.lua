SMODS.Joker{ -- Peashooter
    key = "peashooter",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 4,
    pos = {x = 0, y = 7},
    soul_pos = {x = 0, y = 0},
    config = { extra_slots_used = -1, extra = { chips = 50 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_peashooter"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
}

SMODS.Joker{ -- Sunflower
    key = "sunflower",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 2,
    pos = {x = 0, y = 7},
    soul_pos = {x = 1, y = 0},
    config = { extra_slots_used = -1, extra = { dollars = 1 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_sunflower"))
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end
}

SMODS.Joker{ -- Cherry Bomb
    key = "cherrybomb",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 6,
    pos = {x = 0, y = 7},
    soul_pos = {x = 2, y = 0},
    config = { extra_slots_used = -1, extra = { max_highlighted = 3 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        if card.cost == 1 then
            card.ability.extra_value = -card.cost
        else
            card.ability.extra_value = -math.floor(card.cost/2)
        end
        card:set_cost()
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

SMODS.Joker{ -- Wall-nut
    key = "wallnut",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 2,
    pos = {x = 0, y = 7},
    soul_pos = {x = 3, y = 0},
    config = { extra_slots_used = -1, extra = { hand = 1, discard = 1 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand, card.ability.extra.discard } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_wallnut"))
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if pseudorandom('wallnut', 1, 2) == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.hand)
                        return true
                    end
                }))
                return {
                    message = "+1 Hand",
                    colour = G.C.BLUE
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_discard(card.ability.extra.discard)
                        return true
                    end
                }))
                return {
                    message = "+1 Discard",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{ -- Potato Mine
    key = "potatomine",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 1,
    pos = {x = 0, y = 7},
    soul_pos = {x = 4, y = 0},
    config = { extra_slots_used = -1, extra = { max_highlighted = 3, countdown = 0, countdown_needed = 3 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.countdown, card.ability.extra.countdown_needed } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_potatomine"))
        }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.countdown ~= card.ability.extra.countdown_needed then
                card.ability.extra.countdown = card.ability.extra.countdown + 1
                if card.ability.extra.countdown == card.ability.extra.countdown_needed then
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
            end
            return {
                message = (card.ability.extra.countdown < card.ability.extra.countdown_needed) and (card.ability.extra.countdown .. '/' .. card.ability.extra.countdown_needed) or "ACTIVE",
            }
        end
    end
}

SMODS.Joker{ -- Snow Pea
    key = "snowpea",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 7,
    pos = {x = 0, y = 7},
    soul_pos = {x = 5, y = 0},
    config = { extra_slots_used = -1, extra = { chips = 50, hand = 1 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hand } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand
        ease_hands_played(card.ability.extra.hand)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hand
        ease_hands_played(-card.ability.extra.hand)
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_snowpea"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
}

SMODS.Joker{ -- Chomper
    key = "chomper",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 6,
    pos = {x = 0, y = 7},
    soul_pos = {x = 6, y = 0},
    config = { extra_slots_used = -1, extra = { max_highlighted = 1, countdown = 3, countdown_needed = 3, mult = 0, mult_gain = 10 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.countdown, card.ability.extra.countdown_needed, card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return card.ability.extra.countdown == card.ability.extra.countdown_needed and not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_chomper"))
        }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.countdown ~= card.ability.extra.countdown_needed then
                card.ability.extra.countdown = card.ability.extra.countdown + 1
                if card.ability.extra.countdown == card.ability.extra.countdown_needed then
                    local eval = function(card) return card.ability.extra.countdown == card.ability.extra.countdown_needed and not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
            end
            return {
                message = (card.ability.extra.countdown < card.ability.extra.countdown_needed) and (card.ability.extra.countdown .. '/' .. card.ability.extra.countdown_needed) or "ACTIVE",
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}

SMODS.Joker{ -- Repeater
    key = "repeater",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 8,
    pos = {x = 0, y = 7},
    soul_pos = {x = 7, y = 0},
    config = { extra_slots_used = -1, extra = { chips = 50 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    
    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_repeater"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    chips = card.ability.extra.chips,
                }
            }
        end
    end
}

SMODS.Joker{ -- Puff-shroom
    key = "puffshroom",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 0,
    pos = {x = 0, y = 7},
    soul_pos = {x = 0, y = 1},
    config = { extra_slots_used = -1, extra = { chips = 50 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_puffshroom"))
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end
    end
}

SMODS.Joker{ -- Sun-shroom
    key = "sunshroom",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 1,
    pos = {x = 0, y = 7},
    soul_pos = {x = 1, y = 1},
    config = { extra_slots_used = -1, extra = { countdown = 0, countdown_needed = 10, dollars = 0.5 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.countdown, card.ability.extra.countdown_needed, card.ability.extra.dollars } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_sunshroom"))
        }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.countdown ~= card.ability.extra.countdown_needed then
                card.ability.extra.countdown = card.ability.extra.countdown + 1
                if card.ability.extra.countdown == card.ability.extra.countdown_needed then
                    card.ability.extra.countdown = 0
                    card.ability.extra.dollars = card.ability.extra.dollars * 2
                end
                return {
                    message = card.ability.extra.countdown == 0 and "INCREASE CASH" or (card.ability.extra.countdown < card.ability.extra.countdown_needed) and (card.ability.extra.countdown .. '/' .. card.ability.extra.countdown_needed),
                }
            end
        end
        if context.joker_main then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end
}

SMODS.Joker{ -- Fume-shroom
    key = "fumeshroom",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 2, y = 1},
    config = { extra_slots_used = -1, extra = {} },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    in_pool = function (self, args)
        return true, {
            allow_duplicates = next(SMODS.find_card("j_nic_fumeshroom"))
        }
    end,
}

SMODS.Joker{ -- Grave Buster
    key = "gravebuster",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 3, y = 1},
    config = { extra_slots_used = -1, extra = { max_highlighted = 3, amount = 3 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.amount } }
    end,

    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

SMODS.Joker{ -- Hypno-shroom
    key = "hypnoshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 4, y = 1},
    config = { extra_slots_used = -1, extra = { max_highlighted = 3, amount = 2 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted, card.ability.extra.amount } }
    end,
}

SMODS.Joker{ -- Scaredy-shroom
    key = "scaredyshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 1,
    pos = {x = 0, y = 7},
    soul_pos = {x = 5, y = 1},
    config = { extra_slots_used = -1, extra = { chips = 50, rounds = 1, hand = 1 } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hand, card.ability.extra.discard } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_left ~= 0 then
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end

        if context.main_eval and not context.blueprint then
            if context.end_of_round and context.game_over == false then
                card.ability.extra.rounds = 1
            end
            
            if G.GAME.current_round.hands_left == 0 and card.ability.extra.rounds == 1 then
                card.ability.extra.rounds = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.hand)
                        return true
                    end
                }))
                SMODS.calculate_effect({message = "+1 Hand", colour = G.C.BLUE}, card)
            end
        end
    end
}

SMODS.Joker{ -- Ice-shroom
    key = "iceshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 3,
    pos = {x = 0, y = 7},
    soul_pos = {x = 6, y = 1},
    config = { extra_slots_used = -1, extra = { } },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}

SMODS.Joker{ -- Doom-shroom
    key = "doomshroom",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicpvzjokers',
    rarity = 'nic_plants',
    cost = 5,
    pos = {x = 0, y = 7},
    soul_pos = {x = 7, y = 1},
    config = { extra_slots_used = -1, extra = {} },
    pools = { ["Plants"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    
    add_to_deck = function(self, card, from_debuff)        
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    if (self.config.center.key == 'j_nic_puffshroom') then 
        self.cost = 0 
    end
    if (self.config.center.rarity == "nic_plants") then
        self.sell_cost = 0 
    end
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end