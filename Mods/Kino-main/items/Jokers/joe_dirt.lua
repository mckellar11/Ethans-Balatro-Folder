SMODS.Joker {
    key = "joe_dirt",
    order = 28,
    config = {
        extra = {
            chips = 0,
            chips_mod = 10
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 4},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gains 10 chips when you discard a spade
        if context.discard and not context.other_card.debuff and context.other_card:is_suit("Spades") then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod

            return {
                message = localize('k_upgrade_ex'),
                card = self,
                colour = G.C.CHIPS
            }
        end

        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize({ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips}})
            }
        end
    end
}