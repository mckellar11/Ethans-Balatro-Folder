SMODS.Joker {
  key = 'mismatched_sock',
  config = {
    extra = {
      mult = 0,
      a_mult = 1,
    }
  },
  rarity = 2,
  pos = { x = 6, y = 1 },
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
        card.ability.extra.a_mult,
        card.ability.extra.mult
      }
    }
  end,

  calculate = function(self, card, context)
    -- Upgrade mult if no pairs in scoring_hand
    if context.before and not context.blueprint and context.main_eval then
      -- Keep track of the number of specific ranks in scoring_hand
      local count = {}
      -- Loop over scoring_hand to add them to the count
      for _, v in pairs(context.scoring_hand) do
        -- Only check cards that are not stone cards
        if v.ability.name ~= "Stone Card" then
          local rank = v:get_id()
          count[rank] = (count[rank] or 0) + 1

          -- If duplicates found, do not upgrade Joker
          if count[rank] > 1 then
            return
          end
        end
      end

      -- Upgrade mult
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT,
        card = card
      }
    end

    -- Give mult during scoring
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
  end
}
