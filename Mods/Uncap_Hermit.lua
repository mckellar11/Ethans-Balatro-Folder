--- STEAMODDED HEADER
--- MOD_NAME: Uncap Hermit
--- MOD_ID: Uncap_Hermit
--- MOD_AUTHOR: [Infarctus]
--- MOD_DESCRIPTION: Uncaps the hermit money given

----------------------------------------------
------------MOD CODE -------------------------
Origial_Card_use_consumeable = Card.use_consumeable
function Card:use_consumeable(area, copier)
    stop_use()
    if not copier then set_consumeable_usage(self) end
    if self.debuff then return nil end
    local used_tarot = copier or self

    if self.ability.name == 'The Hermit' then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            used_tarot:juice_up(0.3, 0.5)
            ease_dollars(math.max(0,(G.GAME.dollars)), true)
            return true end }))
        delay(0.6)
        return
    end
    return Origial_Card_use_consumeable(self, area, copier)
end
----------------------------------------------
------------MOD CODE END----------------------