SMODS.Joker {
    key = "memento",
    order = 100,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards trigger twice
        -- When you make an action (discard, play, use/sell consumable/joker)
        -- flip all cards in hand.

        if (context.before or context.pre_discard) 
        and not context.blueprint then
            for j=1, #G.hand.cards do
                G.hand.cards[j]:flip()
            end
        end

        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            return {
                message = 'Again???',
                repetitions = card.ability.extra.repetitions,
                card = context.other_card
            }
        end
    end
}