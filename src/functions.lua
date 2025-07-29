SMODS.current_mod.set_debuff = function(card) -- Debuff
    if next(SMODS.find_card("j_nic_incognito")) and card.playing_card and card:is_suit("Spades") then
        return "prevent_debuff"
    end
    if next(SMODS.find_card("j_nic_doctorkidori")) and card.playing_card and card:get_id() == 4 then
        return "prevent_debuff"
    end
end

to_big = to_big or function(num) -- Talisman Bullshit
    return num
end

to_number = to_number or function(num)
    return num
end

local getiduse = false
local getidref = Card.get_id -- Cards are Considered Rank
function Card:get_id()
	if not getiduse then
		getiduse = true
		local id = getidref(self) or self.base.id
		if next(SMODS.find_card('j_nic_doctorkidori')) and (id == 2 or id == 3 or id == 5 or id == 6 or id == 7 or id == 8 or id == 9 or id == 10 or id == 11 or id == 12 or id == 13 or id == 14) then id = 4 end
		getiduse = false
		return id
	else
		getiduse = false
		return getidref(self)
	end
end

nic = {} -- Vouchers/Boosters

function nic_ctx(context)
    if context.nic_buying_voucher then return 'buy a voucher' end
    if context.nic_buying_booster then return 'buy a booster pack' end
end

nic.hooks = {}

nic.hooks.Card_open = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        SMODS.calculate_context({nic_buying_booster = true, card = self})
    end
    return nic.hooks.Card_open(self)
end

nic.hooks.Card_redeem = Card.redeem
function Card:redeem()
    if self.ability.set == "Voucher" then
        SMODS.calculate_context({nic_buying_voucher = true, card = self})
    end
    return nic.hooks.Card_redeem(self)
end

local function reset_nic_crazytaxi_card() -- Randomize Rank
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

function SMODS.current_mod.reset_game_globals(run_start) -- Timer
    reset_nic_crazytaxi_card()
end

local lcpref = Controller.L_cursor_press -- Cryptid
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
    end
end

local nicmodpress = love.keypressed -- Keypress
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

local hoverref = Card.hover -- Invisible Woman
function Card:hover()
    hoverref(self)
    if self.config.center.key == "j_nic_invisiblewoman" then
        local _atlas, _pos = get_front_spriteinfo(self.config.card)
        _pos = { x = 1, y = 0 }
        _atlas = G.ASSET_ATLAS['nic_invisiblewoman']
        if self.children.front then
            self.children.front.atlas = _atlas
            self.children.front:set_sprite_pos(_pos)
        else
            self.children.front = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, _atlas, _pos)
            self.children.front.states.hover = self.states.hover
            self.children.front.states.click = self.states.click
            self.children.front.states.drag = self.states.drag
            self.children.front.states.collide.can = false
            self.children.front:set_role({major = self, role_type = 'Glued', draw_major = self})
        end
    end
end
local stop_hoverref = Card.stop_hover
function Card:stop_hover()
    stop_hoverref(self)
    if self.config.center.key == "j_nic_invisiblewoman" then
        local _atlas, _pos = get_front_spriteinfo(self.config.card)
        _pos = { x = 0, y = 0 }
        _atlas = G.ASSET_ATLAS['nic_invisiblewoman']
        if self.children.front then
            self.children.front.atlas = _atlas
            self.children.front:set_sprite_pos(_pos)
        else
            self.children.front = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, _atlas, _pos)
            self.children.front.states.hover = self.states.hover
            self.children.front.states.click = self.states.click
            self.children.front.states.drag = self.states.drag
            self.children.front.states.collide.can = false
            self.children.front:set_role({major = self, role_type = 'Glued', draw_major = self})
        end
    end
end
-- card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "71!", colour = HEX("d0d0d0")})