require "keybow"

-- Controls for Pico-8 --

system = "macOS"
-- system = "Windows" -- Uncomment for Windows!

function setup() -- Set custom lights up
    keybow.auto_lights(false)
    keybow.clear_lights()
    keybow.set_pixel(0, 255, 255, 0) -- Green
    keybow.set_pixel(1, 255, 255, 0) -- Green
    keybow.set_pixel(2, 0, 255, 255) -- Cyan
    keybow.set_pixel(3, 255, 0, 255) -- Magenta
    keybow.set_pixel(4, 0, 255, 255) -- Cyan
    keybow.set_pixel(5, 0, 255, 255) -- Cyan
    keybow.set_pixel(6, 255, 0, 255) -- Magenta
    keybow.set_pixel(7, 255, 0, 255) -- Magenta
    keybow.set_pixel(8, 0, 255, 255) -- Cyan
    keybow.set_pixel(9, 255, 0, 255) -- Magenta
    keybow.set_pixel(10, 0, 255, 255) -- Cyan
    keybow.set_pixel(11, 0, 255, 255) -- Cyan
end

-- Key mappings --

function handle_key_00(pressed) -- Action key
    keybow.set_key("x", pressed)
end

function handle_key_01(pressed) -- Action key
    keybow.set_key("z", pressed)
end

function handle_key_02(pressed) -- Quit
    if pressed then
        if system == "macOS" then
            keybow.set_modifier(keybow.LEFT_META, keybow.KEY_DOWN)
            keybow.tap_key("q")
            keybow.set_modifier(keybow.LEFT_META, keybow.KEY_UP)
        elseif system == "Windows" then
            keybow.set_modifier(keybow.LEFT_ALT, keybow.KEY_DOWN)
            keybow.tap_key(keybow.F4)
            keybow.set_modifier(keybow.LEFT_ALT, keybow.KEY_UP)
        end
    end
end

function handle_key_03(pressed) -- Right
    keybow.set_key(keybow.RIGHT_ARROW, pressed)
end

function handle_key_04(pressed) -- Mute
    if pressed then
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_DOWN)
        keybow.tap_key("m")
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_UP)
    end
end

function handle_key_05(pressed) -- Reload
    if pressed then
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_DOWN)
        keybow.tap_key("r")
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_UP)
    end
end

function handle_key_06(pressed) -- Down
    keybow.set_key(keybow.DOWN_ARROW, pressed)
end

function handle_key_07(pressed) -- Up
    keybow.set_key(keybow.UP_ARROW, pressed)
end

function handle_key_08(pressed) -- Enter
    keybow.set_key(keybow.ENTER, pressed)
end

function handle_key_09(pressed) -- Left
    keybow.set_key(keybow.LEFT_ARROW, pressed)
end

function handle_key_10(pressed) -- Save
    if pressed then
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_DOWN)
        keybow.tap_key("s")
        keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_UP)
    end
end

function handle_key_11(pressed) -- Escape
    keybow.set_key(keybow.ESC, pressed)
end
