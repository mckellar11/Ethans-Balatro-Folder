SMODS.Joker {
    key = "the_thing",
    order = 35,
    config = {
        extra = {
            
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 0},
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi", "Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                localize(G.GAME.current_round.kino_thing_card and G.GAME.current_round.kino_thing_card.suit or "Spades", "suits_singular"),
                colours = {
                    G.C.SUITS[G.GAME.current_round.kino_thing_card and G.GAME.current_round.kino_thing_card.suit or "Spades"]
                }
            }
        }
    end
}