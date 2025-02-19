SMODS.Joker {
    key = "benjamin_button",
    order = 78,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama", "Fantasy", "Romance"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers then
            -- iterate through scoring hand
            for i = 1, #context.scoring_hand do
                local i_card = context.scoring_hand[i]
                local suit_prefix = string.sub(i_card.base.suit, 1, 1).."_"
                local rank_suffix = i_card.base.id == 14 and 2 or math.max(2, i_card.base.id-1)

                if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                elseif rank_suffix == 10 then rank_suffix = 'T'
                elseif rank_suffix == 11 then rank_suffix = 'J'
                elseif rank_suffix == 12 then rank_suffix = 'Q'
                elseif rank_suffix == 13 then rank_suffix = 'K'
                elseif rank_suffix == 14 then rank_suffix = 'A'
                end
                i_card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.CHIPS })
            end
        end
    end
}