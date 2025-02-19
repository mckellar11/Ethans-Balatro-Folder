SMODS.Joker {
    key = "fight_club",
    order = 35,
    config = {
        extra = {
            xmult = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Thriller", "Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- x3, and destroy a random scored card.
        if context.joker_main then
            -- Select a random card
            
            local destroyed_card = pseudorandom_element(context.scoring_hand)
            SMODS.calculate_context({destroy_card = destroyed_card})

            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}