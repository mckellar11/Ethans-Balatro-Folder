SMODS.Joker {
    key = "ed_wood",
    order = 54,
    config = {
        extra = {
            blind_piece = 25,
            money = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy", "Drama", "Biopic"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.blind_piece,
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- when your hand scored less than 1/4th of the blind,
        -- earn $3.
        if context.after and context.cardarea == G.jokers then
            if (hand_chips * mult) < G.GAME.blind.chips * (card.ability.extra.blind_piece / 100) then
                ease_dollars(card.ability.extra.money)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    message = localize("$")..card.ability.extra.money,
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
}