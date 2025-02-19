SMODS.Joker {
    key = "piranha_2",
    order = 15,
    config = {
        extra = {
            mult = 8
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 2},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == "High Card" then
                return {
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
}