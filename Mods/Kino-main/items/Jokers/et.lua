SMODS.Joker {
    key = "et",
    order = 27,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 5},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Family", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a high card, create a negative Pluto
        if context.joker_main then
            if context.scoring_name == "High Card" then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("Planet",G.consumeables, nil, nil, nil, nil, "c_pluto", "et")
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
            end
        end
    end
}