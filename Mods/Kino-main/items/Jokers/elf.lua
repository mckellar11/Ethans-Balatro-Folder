SMODS.Joker {
    key = "elf",
    order = 3,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 0 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy", "Christmas"},

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
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:get_id() == 2 or context.other_card:get_id() == 3 then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.repetitions,
                    card = context.other_card
                }
            end
        end
    end
}