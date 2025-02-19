SMODS.Joker {
    key = "scream_1",
    order = 113,
    config = {
        extra = {
            mult = 0,
            a_mult = 2,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 0},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

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
        -- Gain +2 mult for every Horror joker you have at the end of a blind
        -- Lose money equal to this joker's mult when you sell it.
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            print("End of Round?")
            for i, v in ipairs(G.jokers.cards) do
                if is_genre(v, "Horror") then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
                    card.ability.extra_value = card.ability.extra_value - card.ability.extra.a_mult
                    card:set_cost()
                end
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}