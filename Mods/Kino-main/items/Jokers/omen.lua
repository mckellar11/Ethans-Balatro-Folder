SMODS.Joker {
    key = "omen",
    order = 115,
    config = {
        extra = {
            chips = 300,
            req = 13
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.req,
                G.GAME.current_round.sacrifices_made
            }
        }
    end,
    calculate = function(self, card, context)
        -- +300 chips if you've made more than 13 sacrifices this game. 

        if context.joker_main and G.GAME.current_round.sacrifices_made >= card.ability.extra.req then
            return {
                chips = 300
            }
        end
        
    end
}