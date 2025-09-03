local atlas_key = 'nic_atlas' -- Format: PREFIX_KEY
local atlas_path = 'incognito_lc.png' -- Filename for the image in the asset folder
local atlas_path_hc = 'incognito_hc.png' -- Filename for the high-contrast version of the texture, if existing

local suits = {'spades'} -- Which suits to replace
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'} -- Which ranks to replace

local description = 'Incognito'

SMODS.Atlas{
    key = atlas_key..'_lc',
    px = 71,
    py = 95,
    path = atlas_path,
    prefix_config = {key = false},
}

if atlas_path_hc then
    SMODS.Atlas{  
        key = atlas_key..'_hc',
        px = 71,
        py = 95,
        path = atlas_path_hc,
        prefix_config = {key = false},
    }
end

SMODS.DeckSkin {
    key = "incognito_suits",
    suit = "Spades",
    palettes = {
        {
            key = 'lc',
            ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'},
            display_ranks = {"King","Queen","Jack"},
            atlas = atlas_key..'_lc',
            pos_style = "deck",
        },
        {
            key = 'hc',
            ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'},
            display_ranks = {"King","Queen","Jack"},
            atlas = (atlas_path_hc and atlas_key..'_hc') or atlas_key..'_lc',
            pos_style = "deck",
            colour = HEX("d0d0d0"),
        }
    },
    loc_txt = {
        ['en-us'] = description
    },
}