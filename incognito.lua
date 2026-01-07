Incognito = SMODS.current_mod
assert(SMODS.load_file("config.lua"))()

-- Base Stuff

assert(SMODS.load_file("src/jokers.lua"))()
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

-- Teto
assert(SMODS.load_file("src/teto/jokers.lua"))()

-- Ijiraq

if next(SMODS.find_mod('hyperfixation_mod')) then
    SMODS.load_file("src/crossmod/ijiraq.lua")()
    if Hyperfixation and Hyperfixation.hypercross then
        if type(Hyperfixation) == "table" and type(Hyperfixation.hypercross) == "function" then
            Hyperfixation.hypercross('Incognito', 'j_nic_technoblade', 'j_nic_faketechnoblade', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_machinedramon', 'j_nic_fakemachinedramon', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_button', 'j_nic_fakebutton', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_slycooper', 'j_nic_fakeslycooper', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_stalagmite', 'j_nic_fakestalagmite', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonacookie', 'j_nic_fakedalgonacookie', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonacircle', 'j_nic_fakedalgonacircle', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonatriangle', 'j_nic_fakedalgonatriangle', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonastar', 'j_nic_fakedalgonastar', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_dalgonaumbrella', 'j_nic_fakedalgonaumbrella', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_humantorch', 'j_nic_fakehumantorch', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_invisiblewoman', 'j_nic_fakeinvisiblewoman', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_thething', 'j_nic_fakethething', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_misterfantastic', 'j_nic_fakemisterfantastic', false)
            Hyperfixation.hypercross('Incognito', 'j_nic_incognito', 'j_nic_fakeincognito', false)
        end
    end
end

-- Pvz
assert(SMODS.load_file("src/pvz/functions.lua"))()
assert(SMODS.load_file("src/pvz/jokers.lua"))()
assert(SMODS.load_file("src/pvz/zengarden.lua"))()

-- Poopoo

if Incognito.config.scrapped_things then
	SMODS.load_file("src/scrapped/scrapped.lua")()
end

if Incognito.config.roaring_inc then
	SMODS.load_file("src/music.lua")()
end

-- JokerDisplay

if JokerDisplay then
    SMODS.load_file("src/crossmod/jokerdisplay.lua")()
end

-- Partner

if next(SMODS.find_mod("partner")) then
    SMODS.load_file("src/crossmod/partners.lua")()
end