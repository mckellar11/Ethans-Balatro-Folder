SMODS.Joker {
    key = "party_people",
    order = 27,
    config = {
        extra = {
            income = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 4},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Biopic", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.income
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives money equal to interest when scoring a club card.
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                local money = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / 5)
                return {
                    dollars = money,
                    card = context.other_card
                }
            end
        end
    end
}