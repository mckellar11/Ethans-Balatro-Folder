SMODS.Consumable {
    key = "demon",
    set = "Tarot",
    order = 3,
    pos = {x = 2, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_demonic', 
        max_highlighted = 1,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_demonic
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end

}