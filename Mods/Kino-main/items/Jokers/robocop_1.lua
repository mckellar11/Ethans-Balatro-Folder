SMODS.Joker {
    key = "robocop_1",
    order = 13,
    config = {
        extra = {
            rank_discard = 12,
            rank_retrieved = {11, 13}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a High Card is played, turn all scoring unenhanced cards into Sci-fi cards after scoring.

        if context.individual and context.scoring_name == "High Card" and
        context.cardarea == G.play and
        context.other_card.config.center == G.P_CENTERS.c_base and not
        context.blueprint then
            
            context.other_card:set_ability(G.P_CENTERS.m_kino_sci_fi, nil, true)
            
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.MULT })
        end

    end
}