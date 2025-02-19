SMODS.Joker {
    key = "the_man_who_laughs",
    order = 130,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Romance", "Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult,
                ((G.jokers and G.jokers.cards and #G.jokers.cards or 0) - 1) * card.ability.extra.a_xmult + 1
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = 1 + ((G.jokers and G.jokers.cards and #G.jokers.cards or 0) - 1) * card.ability.extra.a_xmult
            }
        end
    end
}