SMODS.Joker {
    key = "stand_by_me",
    order = 65,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 4},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a straight, get a negative hangman
        if context.joker_main and (context.scoring_name == "Straight" or context.scoring_name == "Straight Flush") then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = create_card("Tarot",G.consumeables, nil, nil, nil, nil, "c_hanged_man", "stand_by_me")
                    card:set_edition({negative = true}, true)
                    card:add_to_deck()
                    G.consumeables:emplace(card) 
                    return true
                end}))
            card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
        end

    end
}