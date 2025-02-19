SMODS.Joker {
    key = "the_double",
    order = 6,
    config = {
        extra = {
            mult = 0,
            mult_mod = 2,
            a_mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 0 },
    cost = 3,
    genre = "thriller",
    blueprint_compat = true,
    perishable_compat = false,
    pools, k_genre = {"Thriller"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)

        if context.before and next(context.poker_hands["Two Pair"]) and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                focus = card,
                message = localize({type='variable', key='a_mult', vars = {card.ability.extra.mult}}),
                colour = G.C.MULT,
                card = self
            }

        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.mult_mod = card.ability.extra.mult_mod + card.ability.extra.a_mult
            return {
                focus = card,
                message = localize({type='variable', key='k_upgrade_ex', vars = {card.ability.extra.mult_mod}}),
                colour = G.C.MULT,
                card = self
            }
        end

        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult }},
            }
        end
    end
}