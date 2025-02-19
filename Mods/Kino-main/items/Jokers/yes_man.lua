SMODS.Joker {
    key = "yes_man",
    order = 122,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)

        if context.before and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.discard and not context.repetition and not context.blueprint then
            if card.ability.eternal then
                SMODS.debuff_card(card, true, "yes_man")
            else
                card.getting_sliced = true
                G.E_MANAGER:add_event(Event({func = function()
                    card:juice_up(0.8, 0.8)
                    card:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
        end
    end
}