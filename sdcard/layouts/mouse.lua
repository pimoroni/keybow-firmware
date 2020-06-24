require "keybow"

-- Mousekeys --

button_up = false
button_down = false
button_left = false
button_right = false

button_upleft = false
button_upright = false
button_downleft = false
button_downright = false

button_lmb = false
button_mmb = false
button_rmb = false

mouse_speed = 1

-- Key mappings --

function setup()
    keybow.auto_lights(false)
    keybow.clear_lights()
    keybow.set_pixel(0, 255, 0, 255)
    keybow.set_pixel(1, 255, 0, 255)
    keybow.set_pixel(2, 255, 0, 255)

    keybow.set_pixel(4, 255, 0, 255)
    keybow.set_pixel(6, 255, 0, 255)
    keybow.set_pixel(8, 255, 0, 255)
    keybow.set_pixel(10, 255, 0, 255)
end

function tick()
    local mouse_x = 0
    local mouse_y = 0
    if button_up then
        mouse_y = -mouse_speed
    end
    if button_down then
        mouse_y = mouse_speed
    end
    if button_left then
        mouse_x = -mouse_speed
    end
    if button_right then
        mouse_x = mouse_speed
    end
    if button_upleft then
        mouse_y = -mouse_speed
        mouse_x = -mouse_speed
    end
    if button_upright then
        mouse_y = -mouse_speed
        mouse_x = mouse_speed
    end
    if button_downleft then
        mouse_y = mouse_speed
        mouse_x = -mouse_speed
    end
    if button_downright then
        mouse_y = mouse_speed
        mouse_x = mouse_speed
    end
    keybow.set_mouse_movement(mouse_x, mouse_y)
end

function handle_key_00(pressed)
    keybow.set_mouse_movement(0, 0)
    keybow.set_mouse_button(keybow.MOUSE_LMB, pressed)
end

function handle_key_01(pressed)
    keybow.set_mouse_movement(0, 0)
    keybow.set_mouse_button(keybow.MOUSE_MMB, pressed)
end

function handle_key_02(pressed)
    keybow.set_mouse_movement(0, 0)
    keybow.set_mouse_button(keybow.MOUSE_RMB, pressed)
end

function handle_key_03(pressed)
    button_downleft = pressed
    if pressed then
        keybow.set_pixel(3, 255, 0, 0)
    else
        keybow.set_pixel(3, 0, 0, 0)
    end
end

function handle_key_04(pressed)
    button_down = pressed
    if pressed then
        keybow.set_pixel(4, 255, 0, 0)
    else
        keybow.set_pixel(4, 255, 0, 255)
    end
end

function handle_key_05(pressed)
    button_downright = pressed
    if pressed then
        keybow.set_pixel(5, 255, 0, 0)
    else
        keybow.set_pixel(5, 0, 0, 0)
    end
end

function handle_key_06(pressed)
    button_left = pressed
    if pressed then
        keybow.set_pixel(6, 255, 0, 0)
    else
        keybow.set_pixel(6, 255, 0, 255)
    end
end

function handle_key_07(pressed)
end

function handle_key_08(pressed)
    button_right = pressed
    if pressed then
        keybow.set_pixel(8, 255, 0, 0)
    else
        keybow.set_pixel(8, 255, 0, 255)
    end
end

function handle_key_09(pressed)
    button_upleft = pressed
    if pressed then
        keybow.set_pixel(9, 255, 0, 0)
    else
        keybow.set_pixel(9, 0, 0, 0)
    end
end

function handle_key_10(pressed)
    button_up = pressed
    if pressed then
        keybow.set_pixel(10, 255, 0, 0)
    else
        keybow.set_pixel(10, 255, 0, 255)
    end
end

function handle_key_11(pressed)
    button_upright = pressed
    if pressed then
        keybow.set_pixel(11, 255, 0, 0)
    else
        keybow.set_pixel(11, 0, 0, 0)
    end
end

