SMODS.Joker {
    key = "alien_1",
    order = 117,
    config = {
        extra = {
            chance_cur = 1,
            a_chance = 1,
            chance = 100,
            xmult = 1.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chance_cur,
                card.ability.extra.a_chance,
                card.ability.extra.chance,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Each scored card gives x1.25.
        -- After each hand, 1/100 chance to destroy all jokers. Each scored card increases this by 1.
        -- Reset chance when you sell a joker.
        if context.individual and context.cardarea == G.play then
            card.ability.extra.chance_cur = card.ability.extra.chance_cur + card.ability.extra.a_chance
            return {
                x_mult = card.ability.extra.xmult,
                card = context.other_card
            }
        end

        if context.after then
            if pseudorandom("alien") < ((G.GAME.probabilities.normal * card.ability.extra.chance_cur) / card.ability.extra.chance) then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then 
                            G.jokers.cards[i].getting_sliced = true
                            G.E_MANAGER:add_event(Event({func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                G.jokers.cards[i]:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                end
            end
        end

        if context.selling_card and context.card.config.center.set == 'Joker' then
            card.ability.extra.chance_cur = 1
        end
    end
}