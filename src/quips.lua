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
    key = 'tetowordofthedayloss1',
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

SMODS.JimboQuip{
    key = 'deathloss1',
    type = 'loss',
    extra = { 
        center = 'j_nic_death', 
        sound = 'nic_deathwhistle',
        times = 1,
        pitch = 1,
        particle_colours = { HEX("830000"), HEX("830000"), HEX("830000") }, 
        materialize_colours = { HEX("000000"), HEX("000000"), HEX("000000") } 
    },
    filter = function()
        if next(SMODS.find_card('j_nic_death')) then
            return true, { weight = 100 }
        end
        return false
    end,
}