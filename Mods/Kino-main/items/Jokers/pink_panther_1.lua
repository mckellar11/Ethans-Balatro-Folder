SMODS.Joker {
    key = "pink_panther_1",
    order = 21,
    config = {
        extra = {
            suit = "Diamonds",
            b_chips = 10,
            chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Mystery", "Heist", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.suit,
                card.ability.extra.b_chips,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Diamonds give +10 chips for each other scoring Diamond.
        if context.before and not context.blueprint then
            local num_suit = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.card.suit == card.ability.extra.suit and not v.debuff then
                    num_suit = num_suit + 1
                end
            end
            card.ability.extra.chips = card.ability.extra.b_chips * num_suit
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.suit) then
                return {
                    chips = card.ability.extra.chips,
                    card = context.other_card
                }
            end
        end
    end
}