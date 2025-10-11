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
                                label = "Scrapped Concepts [Mid]",
                                ref_table = Incognito.config,
                                ref_value = "scrapped_things",
                                callback = should_restart,
                            }),
                        },
                    },
                },
            },
        },
    }
end

-- Debuff

SMODS.current_mod.set_debuff = function(card)
    if next(SMODS.find_card("j_nic_incognito")) and card.playing_card and card:is_suit("Spades") then
        return "prevent_debuff"
    end
end

-- Object Type

SMODS.ObjectType({
    key = "Food",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
        self:inject_card(G.P_CENTERS.j_gros_michel)
        self:inject_card(G.P_CENTERS.j_egg)
        self:inject_card(G.P_CENTERS.j_ice_cream)
        self:inject_card(G.P_CENTERS.j_cavendish)
        self:inject_card(G.P_CENTERS.j_turtle_bean)
        self:inject_card(G.P_CENTERS.j_diet_cola)
        self:inject_card(G.P_CENTERS.j_popcorn)
        self:inject_card(G.P_CENTERS.j_ramen)
        self:inject_card(G.P_CENTERS.j_selzer)
    end,
})

-- Talisman Bullshit

to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

-- Cards are Considered Rank

local getiduse = false
local getidref = Card.get_id
function Card:get_id()
	if not getiduse then
		getiduse = true
		local id = getidref(self) or self.base.id
		if next(SMODS.find_card('j_nic_doctorkidori')) then id = 4 end
		getiduse = false
		return id
	else
		getiduse = false
		return getidref(self)
	end
end

-- Vouchers/Boosters

buyingcard = {}

function nic_ctx(context)
    if context.nic_buying_voucher then return 'buy a voucher' end
    if context.nic_buying_booster then return 'buy a booster pack' end
end

buyingcard.hooks = {}

buyingcard.hooks.Card_open = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        SMODS.calculate_context({nic_buying_booster = true, card = self})
    end
    return buyingcard.hooks.Card_open(self)
end

buyingcard.hooks.Card_redeem = Card.redeem
function Card:redeem()
    if self.ability.set == "Voucher" then
        SMODS.calculate_context({nic_buying_voucher = true, card = self})
    end
    return buyingcard.hooks.Card_redeem(self)
end

-- Randomize Rank

local function reset_nic_crazytaxi_card()
    G.GAME.current_round.nic_crazytaxi_card = { rank = 'Ace' }
    local valid_crazytaxi_card = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) then
            valid_crazytaxi_card[#valid_crazytaxi_card + 1] = playing_card
        end
    end
    local crazytaxi_card = pseudorandom_element(valid_crazytaxi_card, 'nic_crazytaxi' .. G.GAME.round_resets.ante)
    if crazytaxi_card then
        G.GAME.current_round.nic_crazytaxi_card.rank = crazytaxi_card.base.value
        G.GAME.current_round.nic_crazytaxi_card.id = crazytaxi_card.base.id
    end
end

-- Timer

function SMODS.current_mod.reset_game_globals(run_start)
    reset_nic_crazytaxi_card()
end

-- Cryptid

local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
    end
end

-- Keypress

local nicmodpress = love.keypressed
function love.keypressed(key)
    if key == "space" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_space = true })
        end
    end
    if key == "d" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_d = true })
        end
    end
    if key == "f1" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_f1 = true })
        end
    end
    return (nicmodpress(key))
end

-- Retrigger Jokers

SMODS.current_mod.optional_features = { cardareas = {}, retrigger_joker = true }

-- card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "71!", colour = HEX("d0d0d0")})