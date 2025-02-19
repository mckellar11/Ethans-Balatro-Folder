SMODS.Joker {
  key = "jimbo_adventure",
  rarity = 1,
  pos = { x = 1, y = 5 },
  atlas = 'jokers_atlas',
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  soul_pos = { x = 2, y = 5 },

  calculate = function(self, card, context)
    if context.skip_blind then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(PB_UTIL.poll_tag("jimbo_adventure"))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))
    end
  end,
}
