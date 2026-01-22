SMODS.Atlas{ -- LobotomyCorp Jokers
    key = "niclobotomycorp",
    path = "crossmod/niclobotomycorp.png",
    px = 71,
    py = 95,
}

SMODS.Joker{ -- Myst Teto
    key = "mysteto",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'niclobotomycorp',
    rarity = "nic_teto",
    cost = 5,
    pos = { x = 1, y = 0 },
    soul_pos = {
        x = 0,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) *
                    math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            rotate_mod = 0.3 * math.sin(10 * G.TIMERS.REAL) +
                0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            card.children.floating_sprite:draw_shader('dissolve',
                0, nil, nil, card.children.center, scale_mod, rotate_mod , nil, 0.1)
            card.children.floating_sprite:draw_shader('dissolve',
                nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    },
    config = { extra = { odds = 4 } },
    pools = { ["Teto"] = true },
    dependencies = { 'LobotomyCorp' },

    abno = true,
    risk = "teth",
    discover_rounds = {1, 4, 7},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds) 
        return { vars = { new_numerator, new_denominator } }
    end,

    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge('TETH', HEX("13A2FF"), nil)
    end,

    calculate = function(self, card, context)        
        if context.before and not context.blueprint and next(context.poker_hands['Pair']) then
            if SMODS.pseudorandom_probability(card, ('j_nic_mysteto'), 1, card.ability.extra.odds) then
                SMODS.destroy_cards(context.scoring_hand)
            end
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end

        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.death_text = "mysteto"
                    G.GAME.death_texture = "niclobotomycorp"
                    G.STATE = G.STATES.GAME_OVER
                    G.FILE_HANDLER.force = true
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if not card then
            card = self:create_fake_card()
        end
        local res = {}
        if self.loc_vars and type(self.loc_vars) == 'function' then
            res = self:loc_vars(info_queue, card) or {}
        end
        res.vars = res.vars or {}
        local name = false

        if not self.discovered and not (card.area == G.jokers or card.area == G.consumeables) then
            localize{type = 'descriptions', key = 'und_'..self.key, set = "Other", nodes = desc_nodes, vars = res.vars, AUT = full_UI_table}
        else
            localize{type = 'descriptions', key = res.key or self.key, set = self.set, nodes = desc_nodes, vars = res.vars, AUT = full_UI_table}
        end

        for k, v in ipairs(self.discover_rounds) do
            local override, true_override
            if self.discover_override then
                if type(self.discover_override) == "table" then
                    override = self.discover_override[k]
                elseif type(self.discover_override) == "function" then
                    override = self:discover_override(k, card)
                    if override then true_override = true end
                end
            end
            if (card:check_rounds() < v or true_override) and not card.debuff then
                if card.area == G.jokers or card.area == G.consumeables or self.discovered then
                    -- First level is in desc_nodes
                    if k == 1 then
                        full_UI_table.main = {}
                        localize{type = 'descriptions', key = (override or "nic_obs"), set = "Other", nodes = full_UI_table.main, vars = {card:check_rounds(), v, k}}
                        full_UI_table.main.main_box_flag = true
                    else
                    -- The rest are in AUT.multi_box
                        full_UI_table.multi_box[k-1] = {}
                        localize{type = 'descriptions', key = (override or "nic_obs"), set = "Other", nodes = full_UI_table.multi_box[k-1], vars = {card:check_rounds(), v, k}}
                    end
                end
            end
        end

        if not self.discovered then
            if not name then
                full_UI_table.name = localize{type = 'name', key = "und_"..self.key, set = "Other", name_nodes = {}, vars = specific_vars or {}}
            end
        else
            full_UI_table.name = localize{type = 'name', key = self.key, set = self.set, name_nodes = {}, vars = specific_vars or {}}
        end
    end,

    set_sprites = function(self, card, front)
        card.children.center.atlas = G.ASSET_ATLAS["nic_niclobotomycorp"]
        local count = lobc_get_usage_count(card.config.center_key)
        if not self.discovered or count < card.config.center.discover_rounds[#card.config.center.discover_rounds] then
            card.children.center:set_sprite_pos({x = 3, y = 0})
            card.children.floating_sprite:set_sprite_pos({x = 4, y = 0})
        else
            card.children.center:set_sprite_pos({x = 2, y = 0})
            card.children.floating_sprite:set_sprite_pos({x = 0, y = 0})
        end
    end
}