SMODS.Joker {
  key = 'derecho',
  config = {
    extra = {
      x_mult_mod = 0.1,
      x_mult = 1
    }
  },
  rarity = 2,
  pos = { x = 0, y = 1 },
  atlas = 'jokers_atlas',
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.x_mult_mod,
        card.ability.extra.x_mult
      }
    }
  end,

  calculate = function(self, card, context)
    if not card.debuff then
      -- Upgrade the Joker when hand is played
      if context.before and context.main_eval and not context.blueprint then
        for i = 1, #context.scoring_hand do
          if context.scoring_hand[i].ability.name ~= "Wild Card" then
            if context.scoring_hand[i]:is_suit("Hearts") or context.scoring_hand[i]:is_suit("Diamonds") then
              return
            end
          end
        end

        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod

        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end

      -- Give the xMult during play
      if context.joker_main and not card.debuff then
        return {
          x_mult = card.ability.extra.x_mult,
          card = card,
        }
      end
    end
  end

}
