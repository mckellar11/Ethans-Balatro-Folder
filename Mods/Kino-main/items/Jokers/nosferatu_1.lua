SMODS.Joker {
    key = "nosferatu_1",
    order = 1,
    config = {
        extra = {
            mult_mod = 2,
            mult = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 0 },
    cost = 2,
    blueprint_compat = true,
    perishable_compat = false,
    pools, k_genre = {"Horror", "Silent"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before and not context.blueprint then
                -- Add mult and drain
                local enhanced = {}
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
                    end
                end

                if #enhanced > 0 then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod * #enhanced
                    return {
                        extra = { focus = card,
                        message = localize({type='variable', key='a_mult', vars = {card.ability.extra.mult}}),
                        colour = G.C.MULT,
                        card = self
                        }
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize({ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult }})
            }
        end
    end
}