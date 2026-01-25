SMODS.Atlas{ -- Blinds
    key = "nicblinds",
    path = "nicblinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

SMODS.Blind {
    key = "monarch",
    dollars = 5,
    mult = 2,
    debuff = { value = "King" },
    atlas = "nicblinds",
    pos = { x = 0, y = 0 },
    boss = { min = 6 },
    boss_colour = HEX("888888"),
}

SMODS.Blind {
    key = "silentshadow",
    dollars = 8,
    mult = 2,
    debuff = { nic_not_disabled = true },
    atlas = "nicblinds",
    pos = { x = 0, y = 1 },
    boss = { showdown = true },
    boss_colour = HEX("d0d0d0"),

    set_blind = function(self)
        love.audio.stop()
    end,

    calculate = function(self, blind, context)
        if context.before and not context.blueprint then
            local hasspades = false
            for i, v in ipairs(context.scoring_hand) do
                if v:is_suit("Spades") then
                    hasspades = true
                end
            end
            if hasspades then
                SMODS.destroy_cards(context.full_hand)
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = math.floor(to_number(G.GAME.blind.chips) * 2)
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        play_sound('nic_swoon')
                        return true
                    end
                }))
                return { message = "X2 Blind", colour = G.C.SUITS.Spades }
            end
        end

        if context.after and not context.blueprint then
            local hasspades = false
            for i, v in ipairs(G.hand.cards) do
                if v:is_suit("Spades") then
                    hasspades = true
                end
            end
            if hasspades then
                local my_pos = nil
                for i, v in ipairs(G.hand.cards) do
                    if v:is_suit("Spades") then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                my_pos = i
                                if my_pos and G.hand.cards[my_pos - 1] then
                                    if not G.hand.cards[my_pos - 1]:is_suit("Spades") then
                                        G.hand.cards[my_pos - 1]:change_suit('Spades')
                                        G.hand.cards[my_pos - 1]:flip()
                                        play_sound('tarot1')
                                    end
                                end
                                if my_pos then
                                    G.hand.cards[my_pos]:flip()
                                    play_sound('tarot1')
                                end
                                if my_pos and G.hand.cards[my_pos + 1] then
                                    if not G.hand.cards[my_pos + 1]:is_suit("Spades") then
                                        G.hand.cards[my_pos + 1]:change_suit('Spades')
                                        G.hand.cards[my_pos + 1]:flip()
                                        play_sound('tarot1')
                                    end
                                end
                                return true
                            end
                        }))
                    end
                end
                for i = 1, #G.hand.cards do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            if G.hand.cards[i].facing == 'back' and G.hand.cards[i]:is_suit("Spades") then
                                G.hand.cards[i]:flip()
                                play_sound('tarot1')
                            end
                            return true
                        end
                    }))
                end
            end
        end
    end
}

local blindDisable = Blind.disable -- AIKO :D
function Blind:disable()
    if self.debuff.nic_not_disabled then
        play_sound('nic_swoon')
        return
    end
    return blindDisable(self)
end