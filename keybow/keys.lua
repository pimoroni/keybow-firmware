require "keybow"

function handle_key_00 (pressed)
    keybow.set_key("0", pressed)
    keybow.load_pattern("test-4x3")
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
    keybow.set_key("1", pressed)
    keybow.auto_lights(not pressed)
    if pressed then
        keybow.clear_lights()
        keybow.set_pixel(3, 255, 0, 0)
    end
end

function handle_key_04 (pressed)
    keybow.set_key("2", pressed)
    keybow.auto_lights(not pressed)
    if pressed then
        keybow.clear_lights()
        keybow.set_pixel(4, 0, 255, 0)
    end
end

function handle_key_05 (pressed)
    --keybow.set_key("3", pressed)
    if pressed then
        keybow.text("function(){Does this work!?}")
    end
end

function handle_key_06 (pressed)
    keybow.set_key("4", pressed)
end

function handle_key_07 (pressed)
    keybow.set_key("5", pressed)
end

function handle_key_08 (pressed)
    keybow.set_key("6", pressed)
end

function handle_key_09 (pressed)
    keybow.set_key("7", pressed)
end

function handle_key_10 (pressed)
    keybow.set_key("8", pressed)
end

function handle_key_11 (pressed)
    keybow.set_key("9", pressed)
end
