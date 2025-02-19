--- CONTROLLER INPUT

-- Collapse
local controller_queue_L_cursor_press_ref = Controller.queue_L_cursor_press
function Controller:queue_L_cursor_press(x, y)
    controller_queue_L_cursor_press_ref(self, x, y)
    local press_node = self.hovering.target or self.focused.target
    if press_node and press_node.name and press_node.name == "JokerDisplay" and press_node.can_collapse and press_node.parent then
        if not JokerDisplay.config.disable_collapse and not press_node.parent.joker_display_values.disabled then
            press_node.parent.joker_display_values.small = not press_node.parent.joker_display_values.small
        end
    end
end

-- Hide
local controller_queue_R_cursor_press_ref = Controller.queue_R_cursor_press
function Controller:queue_R_cursor_press(x, y)
    controller_queue_R_cursor_press_ref(self, x, y)
    local press_node = self.hovering.target or self.focused.target
    if not G.SETTINGS.paused then
        if press_node and G.jokers and ((press_node.area and press_node.area == G.jokers)
                or (press_node.name and press_node.name == "JokerDisplay")) then
            if press_node.name and press_node.name == "JokerDisplay" and press_node.can_collapse and press_node.parent then
                press_node.parent:joker_display_toggle()
            end
            if press_node.ability and press_node.ability.set == 'Joker' then
                press_node:joker_display_toggle()
            end
        end
    else
        if press_node and (press_node.area or (press_node.name and press_node.name == "JokerDisplay")) then
            JokerDisplay.visible = not JokerDisplay.visible
        end
    end
end

local controller_button_press_update_ref = Controller.button_press_update
function Controller:button_press_update(button, dt)
    controller_button_press_update_ref(self, button, dt)
    
    if G.jokers and self.focused.target and self.focused.target.area == G.jokers then
        local press_node = self.hovering.target or self.focused.target
        if press_node and press_node.joker_display_values then
            if button == 'b' then
                press_node:joker_display_toggle()
            elseif button == 'dpup' then
                if not JokerDisplay.config.disable_collapse and not press_node.joker_display_values.disabled then
                    press_node.joker_display_values.small = not press_node.joker_display_values.small
                end
            end
        end
    end
end
