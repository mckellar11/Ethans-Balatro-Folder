SMODS.Joker {
    key = "rocky_1",
    order = 11,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 1 },
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sports"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- upgrade hand if it's the final hand.
        if context.before and G.GAME.current_round.hands_left == 0 then
            return {
                card = self,
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end
}