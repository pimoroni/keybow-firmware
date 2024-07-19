require "keybow"

layer_linux = {}

-- layer setup --

function layer_linux.setup()
    keybow.use_mini()
    keybow.auto_lights(false)
    keybow.clear_lights()
    keybow.set_pixel(0, 155, 0, 155)
    keybow.set_pixel(1, 155, 0, 155)
    keybow.set_pixel(2, 255, 0, 255)
end

-- Key mappings --

function layer_linux.handle_minikey_00(pressed)
    if pressed then
        keybow.set_pixel(0, 255, 0, 255)
        keybow.set_modifier(keybow.LEFT_META, keybow.KEY_DOWN)
        keybow.tap_key("d", pressed)
        keybow.set_modifier(keybow.LEFT_META, keybow.KEY_UP)
    else
        keybow.set_pixel(0, 155, 0, 155)
    end
end

function layer_linux.handle_minikey_01(pressed)
    if pressed then
        keybow.set_pixel(1, 255, 0, 255)
        keybow.set_modifier(keybow.LEFT_META, keybow.KEY_DOWN)
        keybow.tap_key(keybow.ENTER, pressed)
        keybow.set_modifier(keybow.LEFT_META, keybow.KEY_UP)
    else
        keybow.set_pixel(1, 155, 0, 155)
    end
end

function layer_linux.handle_minikey_02(pressed)
    if pressed then
        keybow.set_pixel(2, 155, 0, 155)
    else
        keybow.set_pixel(2, 255, 0, 255)
    end
end
