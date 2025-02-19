SMODS.Joker {
    key = "batman_1989",
    order = 53,
    config = {
        extra = {
            a_mult = 3,
            total = 0,
            mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Superhero", "Action"},
    j_is_batman = true,

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.total,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- At the end of the round, gain +3 for each open joker slot.\
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.total = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.mult
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.j_is_batman then card.ability.extra.total = card.ability.extra.total * card.ability.extra.mult end
            end
        end

        if context.end_of_round and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.total
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}