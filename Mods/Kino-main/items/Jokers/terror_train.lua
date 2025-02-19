SMODS.Joker {
    key = "terror_train",
    order = 109,
    config = {
        extra = {
            chance = 10,
            total_chance = 1,
            a_chance = 1,
            xmult = 3,
            destroy_cards = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chance,
                G.GAME.probabilities.normal * card.ability.extra.total_chance,
                card.ability.extra.a_chance,
                card.ability.extra.xmult,
                card.ability.extra.destroy_cards
            }
        }
    end,
    calculate = function(self, card, context)
        --  Cards have a 1/10 chance to jump scare. 
        -- Whenever you play a high card, increase it by 1. (Jump Scare == give X3, get destroyed after scoring.)
        -- Card Destruction through jump scares needs to be INJECTED
        if context.before and context.scoring_name == "High Card" then
            card.ability.extra.total_chance = card.ability.extra.total_chance + card.ability.extra.a_chance
        end

        if context.individual and context.cardarea == G.play then
            if pseudorandom('terror_train') < (G.GAME.probabilities.normal * card.ability.extra.total_chance) / card.ability.extra.chance then
                card.ability.extra.destroy_cards[#card.ability.extra.destroy_cards + 1] = context.other_card
                return {
                    Xmult_mod = card.ability.extra.xmult, 
                    message = localize({type='variable', key='k_jump_scare'}),
                    colour = HEX("372a2d"),
                    card = context.other_card
                }
            end
        end

        if context.destroying_card and #card.ability.extra.destroy_cards > 0 then
            for i, card in ipairs(card.ability.extra.destroy_cards) do
                if context.destroying_card == card then
                    return true
                end
            end
        end
    end
}