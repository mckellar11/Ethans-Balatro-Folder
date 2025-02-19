SMODS.Joker {
    key = "big_short",
    order = 34,
    config = {
        extra = {
            earned = 1,
            earned_per = 5,
            double_chance = 20,
            destroy_chance = 10,
            destroy_floor = 1,
            destroy_increment = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = false,
    pools, k_genre = {"Drama", "Financial"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.earned,
                card.ability.extra.earned_per,
                card.ability.extra.double_chance,
                card.ability.extra.destroy_chance,
                card.ability.extra.destroy_floor,
                card.ability.extra.destroy_increment,
                (G.GAME.probabilities.normal or 1)
            }
        }
    end,
    calc_dollar_bonus = function(self, card)
        local money = 0

        -- Check for set money
        if pseudorandom('big_short') < (G.GAME.probabilities.normal * card.ability.extra.destroy_floor) / card.ability.extra.destroy_chance then
            G.GAME.dollars = 0
        end

        card.ability.extra.destroy_floor = card.ability.extra.destroy_floor + card.ability.extra.destroy_increment

        money = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.earned_per) * 1

        -- Check for the doubling bonus
        if pseudorandom('big_short') < G.GAME.probabilities.normal / card.ability.extra.double_chance then
            money = G.GAME.dollars
        end
        
        -- Check for set money
        return money
    end
}