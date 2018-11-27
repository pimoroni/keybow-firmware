require "keybow"

function handle_key_00 (pressed)
    keybow.set_key(0x27, pressed)
end

function handle_key_01 (pressed)
    --keybow.set_key(0x37, pressed)
    if pressed then
        keybow.tap_left_meta()
        keybow.sleep(500)
        keybow.text("Text Editor")
        keybow.sleep(500)
        keybow.tap_enter()
    end
end

function handle_key_02 (pressed)
    if pressed then
        keybow.text("Hello World")
    else
        keybow.text("The quick brown fox jumped over the lazy dog")
    end
end

function handle_key_03 (pressed)
    keybow.set_key(0x1e, pressed)
    keybow.auto_lights(not pressed)
    if pressed then
        keybow.clear_lights()
        keybow.set_pixel(3, 255, 0, 0)
    end
end

function handle_key_04 (pressed)
    keybow.set_key(0x1f, pressed)
    keybow.auto_lights(not pressed)
    if pressed then
        keybow.clear_lights()
        keybow.set_pixel(4, 0, 255, 0)
    end
end

function handle_key_05 (pressed)
    keybow.set_key(0x20, pressed)
end

function handle_key_06 (pressed)
    keybow.set_key(0x21, pressed)
end

function handle_key_07 (pressed)
    keybow.set_key(0x22, pressed)
end

function handle_key_08 (pressed)
    keybow.set_key(0x23, pressed)
end

function handle_key_09 (pressed)
    keybow.set_key(0x24, pressed)
end

function handle_key_10 (pressed)
    keybow.set_key(0x25, pressed)
end

function handle_key_11 (pressed)
    keybow.set_key(0x26, pressed)
end
