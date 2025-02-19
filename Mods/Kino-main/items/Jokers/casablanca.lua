SMODS.Joker {
    key = "casablanca",
    order = 2,
    config = {
        extra = {
            mult = 2,
            chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 0 },
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Romance", "Noir"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs") then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    card = context.other_card
                }
            end
        end
    end
}