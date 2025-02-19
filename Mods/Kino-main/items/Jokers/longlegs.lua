SMODS.Joker {
    key = "longlegs",
    order = 118,
    config = {
        extra = {
            x_mult = 3,
            hidden_card = nil
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror", "Crime"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.hidden_card
            }
        }
    end,
    calculate = function(self, card, context)
        -- 3x. When you destroy or play the hidden card, debuff and set score to 0.
        if not card.ability.extra.hidden_card and not context.blueprint then
            card.ability.extra.hidden_card = pseudorandom_element(G.deck.cards)
        end

        if context.joker_main and not card.ability.extra.hidden_card == nil then
            -- Check if the card is the hidden card.
            local _turned_on = true
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card.ability.extra.hidden_card then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_longlegs_ex'), colour = G.C.RED })
                    card_eval_status_text(context.scoring_hand[i], 'extra', nil, nil, nil,
                    { message = localize('k_longlegs_ex'), colour = G.C.RED })
                    G.GAME.chips = 0
                    G.E_MANAGER:add_event(Event({
                        trigger = 'ease',
                        blocking = false,
                        ref_table = G.GAME,
                        ref_value = 'chips',
                        ease_to = G.GAME.chips,
                        delay =  0.5,
                        func = (function(t) return math.floor(t) end)
                      }))
                      _turned_on = false
                      SMODS.debuff_card(card, true, "longlegs")
                    break
                end
            end

            if _turned_on then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end

        if context.destroy_card == card.ability.extra.hidden_card then
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_longlegs_ex'), colour = G.C.RED })
            SMODS.debuff_card(card, true, "longlegs")
        end
    end
}