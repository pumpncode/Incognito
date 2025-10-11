SMODS.Sticker {
    key = "tetosticker",
    badge_colour = HEX("e15d73"),
    rate = 0.0,
    atlas = "nicstickers",
    pos = { x = 0, y = 0 },
    config = { repetitions = 1 },

    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX('e15d73') }} }
    end, 

}
