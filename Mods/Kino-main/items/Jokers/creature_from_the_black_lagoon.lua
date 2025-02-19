SMODS.Joker {
    key = "creature_from_the_black_lagoon",
    order = 13,
    config = {
        extra = {
            perma_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 2 },
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror", "Romance", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.perma_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- If your played hand is only a Queen, destroy it and upgrade every card in your deck with +1 mult.

        -- Checks if only 1 card is played, and if it's a Queen.
        if context.destroying_card and not context.blueprint then 
            if #context.full_hand == 1 and context.full_hand[1]:get_id() == 12 then
                -- Iterate through every owned card.
                for i, v in ipairs(G.deck.cards) do
                    v.ability.perma_mult = v.ability.perma_mult or 0
                    v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.perma_mult
                end
                return true
            end
        end
    end
}
