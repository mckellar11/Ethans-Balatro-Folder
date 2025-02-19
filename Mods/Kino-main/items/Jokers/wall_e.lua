SMODS.Joker {
    key = "wall_e",
    order = 85,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi", "Animated", "Family"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                G.GAME.current_round.scrap_total
            }
        }
    end,
    calculate = function(self, card, context)
        --When you discard a steel card, gain scrap. When a sci-fi card upgrades, upgrade it an additional time for each scrap you have.
        if context.discard and not context.other_card.debuff and context.other_card.config.center == G.P_CENTERS.m_steel 
        and not context.blueprint then
            update_scrap(1)              
        end
    end
}