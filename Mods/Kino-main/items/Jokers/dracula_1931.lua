SMODS.Joker {
    key = "dracula_1931",
    order = 123,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.1,
            aa_xmult = 0.2
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult,
                card.ability.extra.aa_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Debuffs scored cards. Gains x0.1 per card debuff. Gains x0.2 instead if they were enhanced.
        
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            -- suck up the enhancement
            local enhanced = {}
            local unenhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
                    enhanced[#enhanced+1] = v
                    v.vampired = true
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            v.vampired = nil
                            return true
                        end
                    }))
                elseif not v.debuff and not v.vampired then 
                    unenhanced[#unenhanced+1] = v
                    SMODS.debuff_card(v, true, card.config.center.key)
                    v.vampired = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            v.vampired = nil
                            return true
                        end
                    }))
                end
            end

            local enhanced_bonus = #enhanced * card.ability.extra.aa_xmult
            local unenhanced_bonus = #enhanced * card.ability.extra.a_xmult
            card.ability.extra.x_mult = card.ability.extra.x_mult + enhanced_bonus + unenhanced_bonus

            return {
                extra = { focus = card,
                message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.x_mult}}),
                colour = G.C.MULT,
                card = self
                }
            }
        end

        if context.joker_main and card.ability.extra.x_mult ~= 1 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize({type = 'variable', key ='a_xmult', vars = {card.ability.extra.x_mult}})
            }
        end

    end
}