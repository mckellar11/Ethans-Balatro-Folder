SMODS.Joker {
    key = "krazy_house",
    order = 116,
    config = {
        extra = {
            xmult = 1,
            xrange = 0.05,
            xrange_int = 1,
            a_xrange = 2,
            is_first = true

        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 1},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xrange,
                card.ability.extra.xrange_int,
                1 - card.ability.extra.xrange_int * card.ability.extra.xrange_int,
                1 + card.ability.extra.xrange * card.ability.extra.xrange_int,
                card.ability.extra.xrange * card.ability.extra.a_xrange,
                card.ability.extra.a_xrange,
                card.ability.extra.is_first
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if ((context.scoring_name == "Full House" or
            context.scoring_name == "Flush House") and not context.blueprint) 
            or card.ability.extra.is_first == true then
                card.ability.extra.is_first = false
                card.ability.extra.xrange_int = card.ability.extra.xrange_int + card.ability.extra.a_xrange

                local _min = -1 * card.ability.extra.xrange_int
                local _max = card.ability.extra.xrange_int
                print(_min .. " is min. " .. _max .. " is max.")
                local _rand = pseudorandom("krazy", _min, _max)
                print(_rand .. " is rand.")
                card.ability.extra.xmult = 1 + (_rand * card.ability.extra.xrange)
            end

            return {
                xmult = card.ability.extra.xmult
            }
        end

        

    end
}