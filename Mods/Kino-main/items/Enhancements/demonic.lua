SMODS.Enhancement {
    key = "demonic",
    atlas = "kino_enhancements",
    pos = { x = 1, y = 0},
    config = {
        x_mult = 3
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.x_mult or self.config.x_mult
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- When scored, x3, then destroy the hand.
            if (context.main_scoring and context.cardarea == G.play and not context.repetition) then
                local sacrifices = false
                for i = 1, #context.scoring_hand do
                    if not SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_demonic') then
                        sacrifices = true
                        break
                    end
                end

                if sacrifices then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_sacrifice'), colour = G.C.BLACK })
                end
            end
    end
}