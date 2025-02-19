SMODS.Joker {
    key = "angel_hearts",
    order = 26,
    config = {
        extra = {
            base_mult = 1,
            mult = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 4},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},
    -- pools = self.k_genre,

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
                local final_mod = card.ability.extra.mult
                card.ability.extra.mult = card.ability.extra.mult * 2
                return {
                    mult = final_mod,
                    card = context.other_card
                }
            end
        end
        if context.end_of_round and not context.repetition and not context.individual then
            card.ability.extra.mult = card.ability.extra.base_mult
        end
    end
}