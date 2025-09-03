-- Win

SMODS.JimboQuip{
    key = 'tetowordofthedaywin1',
    type = 'win',
    extra = { 
        center = 'j_nic_tetowordoftheday', 
        sound = 'nic_tetowordoftheday',
        times = 1,
        particle_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") }, 
        materialize_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_tetowordoftheday')) then
            return true, { weight = 100 }
        end
        return false
    end,
}

SMODS.JimboQuip{
    key = 'peartowin1',
    type = 'win',
    extra = { 
        center = 'j_nic_pearto', 
        particle_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") }, 
        materialize_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_pearto')) then
            return true, { weight = 100 }
        end
        return false
    end,
}

-- Loss

SMODS.JimboQuip{
    key = 'tetowordofthedaylose1',
    type = 'loss',
    extra = { 
        center = 'j_nic_tetowordoftheday', 
        sound = 'nic_tetowordoftheday',
        times = 1,
        particle_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") }, 
        materialize_colours = { HEX("e15d73"), HEX("e15d73"), HEX("e15d73") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_tetowordoftheday')) then
            return true, { weight = 100 }
        end
        return false
    end,
}