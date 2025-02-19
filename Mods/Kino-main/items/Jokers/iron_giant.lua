SMODS.Joker {
    key = "iron_giant",
    order = 83,
    config = {
        extra = {
            x_mult = 1.00,
            a_xmult = 0.1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi", "Animated", "Family"},

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
        -- sci_fi cards give x1.00 + x0.1 for each time they've upgraded, when held in hand.
        if context.individual and context.cardarea == G.hand and 
        context.other_card.config.center == G.P_CENTERS.m_kino_sci_fi then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED,
                    card = self,
                }
            end

            local level = context.other_card.ability.times_upgraded
            if level > 0 then
                local _x_mult = card.ability.extra.x_mult + (card.ability.extra.a_xmult * level)
                return {
                    x_mult = _x_mult,
                    message = localize{type='variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}}
                }
            end
        end
    end
}