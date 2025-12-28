SMODS.Booster{
    key = 'teto_booster',
    loc_txt = {
        name = "Teto Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:nic_teto} Teto{} cards",
        },
        group_name = {
            "Teto Pack"
        }
    },
    atlas = 'nicboosters',
    pos = {x = 0,y = 0},
    discovered = true,
    weight = 0,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Teto',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("e15d73")})
    end,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        play_sound("nic_tetoohmygodmypenis")
        return { 
            set = "Teto", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "Teto",
    cards = {},
    default = 'j_nic_kasanejokto',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'vase_booser1',
    loc_txt = {
        name = "Vase Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:nic_plants} Vase{} cards",
        },
        group_name = {
            "Vase Pack"
        }
    },
    atlas = 'nicboosters',
    pos = {x = 0,y = 1},
    discovered = true,
    weight = 1,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Vase',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("96603f")})
    end,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        return { 
            set = "Vase", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "Vase",
    cards = {},
    default = 'c_nic_mysteryvase',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'vase_booser2',
    loc_txt = {
        name = "Vase Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:nic_plants} Vase{} cards",
        },
        group_name = {
            "Vase Pack"
        }
    },
    atlas = 'nicboosters',
    pos = {x = 1,y = 1},
    discovered = true,
    weight = 0.05,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Vase',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("408c2f")})
    end,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        return { 
            set = "PlantsVase", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "PlantsVase",
    cards = {},
    default = 'c_nic_plantsvase',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}

SMODS.Booster{
    key = 'tools_booster',
    loc_txt = {
        name = "Tools Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:nic_plants} Zen Garden{} cards",
        },
        group_name = {
            "Tools Pack"
        }
    },
    atlas = 'nicboosters',
    pos = {x = 2,y = 1},
    discovered = true,
    weight = 1,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    kind = 'Tools',
    select_card = 'consumeables',
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = HEX("92431c")})
    end,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        return {
            set = "Tools", 
            area = G.pack_cards,
            skip_materialize = true,

        }
    end,
}

SMODS.ObjectType{
    key = "Tools",
    cards = {},
    default = 'c_nic_mysteryvase',
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
}