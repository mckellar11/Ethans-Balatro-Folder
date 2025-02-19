SMODS.Consumable {
    key = "droid",
    set = "Tarot",
    order = 2,
    pos = {x = 1, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_sci_fi', 
        max_highlighted = 1,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_sci_fi
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end

}