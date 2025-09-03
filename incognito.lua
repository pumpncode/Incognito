Incognito = SMODS.current_mod
assert(SMODS.load_file("config.lua"))()

if Incognito.config.other_jokers then
	SMODS.load_file("src/jokers.lua")()
end

if Incognito.config.teto_things then
	SMODS.load_file("src/teto/jokers.lua")()
    SMODS.load_file("src/teto/stickers.lua")()
    SMODS.load_file("src/teto/tarots.lua")()
end

if Incognito.config.scrapped_things then
	SMODS.load_file("src/scrapped/scrapped.lua")()
end

assert(SMODS.load_file("src/assets.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/functions.lua"))()
assert(SMODS.load_file("src/quips.lua"))()
assert(SMODS.load_file("src/rarity.lua"))()
assert(SMODS.load_file("src/texturedeck.lua"))()