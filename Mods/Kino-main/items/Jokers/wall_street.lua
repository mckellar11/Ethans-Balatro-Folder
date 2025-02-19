SMODS.Joker {
    key = "wall_street",
    order = 29,
    config = {
        extra = {
            money = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you discard a card, increase the sell value of this card by 1. When you play a card, 1/20 chance to divide the sell value of this card by 10
        if context.discard then
            local num_disc = 0
            for i in context.full_hand do
                num_disc = num_disc + 1
            end
            card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.money
            self:set_cost()
        end
    end
}