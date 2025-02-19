SMODS.Joker {
    key = "ghost_rider_1",
    order = 120,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Superhero", "Action", "Fantasy"},

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
        -- Destroy a random Demonic card in hand to gain x.25
        if context.joker_main and not context.blueprint then
            print("Entered")
            local _demons = {}
            for i = 1, #G.hand.cards do
                if SMODS.has_enhancement(G.hand.cards[i], 'm_kino_demonic') then
                    _demons[#_demons + 1] = G.hand.cards[i]
                end
            end

            if #_demons > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_ghost_rider_1'), colour = G.C.BLACK })
                local _destroyed_card = pseudorandom_element(_demons)
                _destroyed_card.destroyed = true

                G.E_MANAGER:add_event(Event({
                    func = function()
                        if SMODS.has_enhancement(_destroyed_card, 'm_glass') then
                            _destroyed_card:shatter()
                        else
                            _destroyed_card:start_dissolve()
                        end
                      return true
                    end
                  }))

                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult
            end

            if card.ability.extra.x_mult > 0 then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}