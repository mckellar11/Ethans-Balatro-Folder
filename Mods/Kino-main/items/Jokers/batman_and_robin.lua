SMODS.Joker {
    key = "batman_and_robin",
    order = 30,
    config = {
        extra = {
            mult = 1,
            total = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    j_is_batman = true,
    pools, k_genre = {"Superhero", "Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.total
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a pair, upgrade both cards with +3 mult for each empty joker slot or batman joker you have
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.total = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.mult
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.j_is_batman then card.ability.extra.total = card.ability.extra.total * card.ability.extra.mult end
            end
        end
        
        if context.individual and context.cardarea == G.play then
            if context.scoring_name == "Pair" then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.total
            end
        end
    end
}