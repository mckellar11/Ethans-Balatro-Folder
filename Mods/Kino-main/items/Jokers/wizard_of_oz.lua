SMODS.Joker {
    key = "wizard_of_oz",
    order = 131,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama"},

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
        if context.individual and context.cardarea == G.play and 
        context.other_card.config.center == G.P_CENTERS.m_wild then
            return {
                x_mult = card.ability.extra.x_mult,
                card = context.other_card
            }
        end
    end
}