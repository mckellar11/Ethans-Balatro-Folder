SMODS.Joker {
    key = "stripes",
    order = 69,
    config = {
        extra = {
            mult = 0,
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 5},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you draw a card, +1 mult.
        -- When you discard a card, -1 mult.
        if context.hand_drawn and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.a_mult * #context.hand_drawn)
        end

        if context.discard and context.cardarea == G.jokers  and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult - (card.ability.extra.a_mult * #context.full_hand)
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

    end
}