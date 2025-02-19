SMODS.Joker {
    key = "ai_artificial",
    order = 88,
    config = {
        extra = {
            a_mult = 1,
            mult = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.mult,
            }
        }
    end,
    calculate = function(self, card, context)
        -- gain 1 mult for every time a sci-fi card has been upgraded.
        if context.joker_main then
            local _mult = card.ability.extra.a_mult * G.GAME.current_round.sci_fi_upgrades
            return {
                mult = _mult
            }
        end

    end
}