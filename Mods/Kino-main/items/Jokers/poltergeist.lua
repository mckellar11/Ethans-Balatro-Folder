SMODS.Joker {
    key = "poltergeist",
    order = 114,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_kino_demonic') and not context.other_card.debuffed then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = context.other_card
                }
            end
        end
    end
}