SMODS.Consumable {
  key = 'eight_of_cups',
  set = 'paperback_minor_arcana',
  config = {
    max_highlighted = 4
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 0, y = 1 },
  unlocked = true,
  discovered = true,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.max_highlighted
      }
    }
  end,

  use = function(self, card, area)
    local suits = {}

    for k, _ in pairs(SMODS.Suits) do
      suits[k] = k
    end

    for _, v in ipairs(G.hand.highlighted) do
      if SMODS.has_enhancement(v, 'm_wild') then
        suits = {}
        break
      end

      if not SMODS.has_no_suit(v) then
        suits[v.base.suit] = nil
      end
    end

    local suit = pseudorandom_element(suits, pseudoseed('eight_of_cups'))

    PB_UTIL.use_consumable_animation(card, G.hand.highlighted, function()
      if suit then
        for _, v in ipairs(G.hand.highlighted) do
          SMODS.change_base(v, suit, nil)
        end
      end
    end)
  end
}
