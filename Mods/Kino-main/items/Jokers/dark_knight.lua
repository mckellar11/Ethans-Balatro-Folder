SMODS.Joker {
    key = "dark_knight",
    order = 104,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    j_is_batman = true,
    pools, k_genre = {"Superhero", "Action"},

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
        -- When you select a blind, destroy all JOKERS
        -- Gain x0.5 per joker destroyed.
        -- Can't destroy batman jokers.

        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local _jokers_destroyed = 0
            for i = 1, #G.jokers.cards do
                print(card.j_is_batman)
                if not G.jokers.cards[i].config.center.j_is_batman and not G.jokers.cards[i].ability.eternal then
                    _jokers_destroyed = _jokers_destroyed + 1
                    G.jokers.cards[i].getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        G.jokers.cards[i]:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                end
            end

            if _jokers_destroyed > 0 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + (_jokers_destroyed * card.ability.extra.a_xmult)
                return {
                    extra = { focus = card,
                    message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.x_mult}}),
                    colour = G.C.MULT,
                    card = self
                    }
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

    end
}