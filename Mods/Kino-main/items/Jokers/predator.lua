SMODS.Joker {
    key = "predator",
    order = 40,
    config = {
        extra = {
            predator_card = nil,
            x_mult = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 0},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.predator_card,
                card.ability.extra.x_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        -- Turn one of the cards in your opening hand into a hidden predator card.
        -- Gives x3 when triggered.
        if context.first_hand_drawn and card.ability.extra.predator_card == nil and not context.blueprint then
           card.ability.extra.predator_card = pseudorandom_element(context.hand_drawn)
        end

        if context.individual and context.other_card == card.ability.extra.predator_card and
        context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.predator_card == nil then
            card.ability.extra.predator_card = nil
        end
    end
}