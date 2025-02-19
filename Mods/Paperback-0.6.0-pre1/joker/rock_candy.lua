SMODS.Joker {
  key = 'rock_candy',
  config = {
    extra = {
      mult = 10,
      odds = 4
    }
  },
  rarity = 1,
  pos = { x = 7, y = 8 },
  atlas = 'jokers_atlas',
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = false,
  yes_pool_flag = "rock_candy_can_spawn",
  pools = {
    Food = true
  },
  paperback = {
    requires_stars = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult,
        G.GAME.probabilities.normal,
        card.ability.extra.odds
      }
    }
  end,

  calculate = function(self, card, context)
    -- Give the mult during play if card is a Star
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit("paperback_Stars") then
        return {
          mult = card.ability.extra.mult,
          card = card
        }
      end
    end

    -- Check if the Joker needs to be eaten
    if context.end_of_round and not context.blueprint and context.main_eval then
      if pseudorandom("rock_candy") < G.GAME.probabilities.normal / card.ability.extra.odds then
        PB_UTIL.destroy_joker(card, function()
          -- Remove Rock Candy from the pool
          G.GAME.pool_flags.rock_candy_can_spawn = false

          -- Create Rockin' Stick
          SMODS.add_card {
            key = 'j_paperback_rockin_stick',
            edition = card.edition
          }
        end)

        return {
          message = localize('k_eaten_ex'),
          colour = G.C.MULT
        }
      else
        return {
          message = localize('k_safe_ex'),
          colour = G.C.CHIPS
        }
      end
    end
  end
}
