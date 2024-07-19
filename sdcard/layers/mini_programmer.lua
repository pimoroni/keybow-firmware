require "keybow"

layer_programmer = {}

-- layer setup --

function layer_programmer.setup()
    keybow.use_mini()
    keybow.auto_lights(false)
    keybow.clear_lights()
    keybow.set_pixel(0, 0, 155, 0)
    keybow.set_pixel(1, 0, 155, 0)
    keybow.set_pixel(2, 0, 255, 0)
end

-- Key mappings --

function layer_programmer.handle_minikey_00(pressed)
    keybow.set_key("v", pressed)
    if pressed then
        keybow.set_pixel(0, 0, 255, 0)
    else
        keybow.set_pixel(0, 0, 155, 0)
    end
end

function layer_programmer.handle_minikey_01(pressed)
    keybow.set_key("c", pressed)
    if pressed then
        keybow.set_pixel(1, 0, 255, 0)
    else
        keybow.set_pixel(1, 0, 155, 0)
    end
end

function layer_programmer.handle_minikey_02(pressed)
    if pressed then
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_DOWN)
        keybow.set_pixel(2, 0, 155, 0)
    else
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_UP)
        keybow.set_pixel(2, 0, 255, 0)
    end
end