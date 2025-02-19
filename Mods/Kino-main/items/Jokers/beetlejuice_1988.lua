SMODS.Joker {
    key = "beetlejuice_1988",
    order = 47,
    config = {
        extra = {
            x_mult = 2
        }
    },
    rarity = 3,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Fantasy", "Comedy"},
    -- pools = self.k_genre,

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
        -- After you've played a hand a multiple of 3 times,
        -- 2x.
        if context.joker_main then
            if G.GAME.hands[context.scoring_name].played % 3 == 0 then
                return {
                    message = localize{type='variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.x_mult,
                }
            end
        end
    end
}