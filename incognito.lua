Incognito = SMODS.current_mod
assert(SMODS.load_file("config.lua"))()

assert(SMODS.load_file("src/jokers.lua"))()

-- Teto
assert(SMODS.load_file("src/teto/jokers.lua"))()

-- Pvz
assert(SMODS.load_file("src/pvz/functions.lua"))()
assert(SMODS.load_file("src/pvz/jokers.lua"))()
assert(SMODS.load_file("src/pvz/zengarden.lua"))()

if Incognito.config.scrapped_things then
	SMODS.load_file("src/scrapped/scrapped.lua")()
end

if JokerDisplay then
    SMODS.load_file("src/crossmod/jokerdisplay.lua")()
end

if next(SMODS.find_mod("partner")) then
    SMODS.load_file("src/crossmod/partners.lua")()
end

assert(SMODS.load_file("src/assets.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file("src/draw.lua"))()
assert(SMODS.load_file("src/functions.lua"))()
assert(SMODS.load_file("src/quips.lua"))()
assert(SMODS.load_file("src/rarity.lua"))()
assert(SMODS.load_file("src/stickers.lua"))()
assert(SMODS.load_file("src/tarots.lua"))()
assert(SMODS.load_file("src/texturedeck.lua"))()
assert(SMODS.load_file("src/ui.lua"))()