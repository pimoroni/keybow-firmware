require "keybow"

-- Handy hotkeys for Adobe Lightroom Classic CC --

meta_key = keybow.LEFT_META -- For macOS
-- meta_key = keybow.LEFT_CTRL -- For Windows

-- Key mappings --

function handle_key_00(pressed) -- Add to quick collection
    keybow.set_key("b", pressed)
end

function handle_key_01(pressed) -- Crop
    keybow.set_key("r", pressed)
end

function handle_key_02(pressed) -- Cycle lights mode
    keybow.set_key("l", pressed)
end

function handle_key_03(pressed) -- Reject
    keybow.set_key("x", pressed)
end

function handle_key_04(pressed) -- Full screen
    keybow.set_key("f", pressed)
end

function handle_key_05(pressed) -- Compare view
    keybow.set_key("c", pressed)
end

function handle_key_06(pressed) -- Flag
    keybow.set_key("p", pressed)
end

function handle_key_07(pressed) -- Zoom in
    if pressed then
        keybow.set_modifier(meta_key, keybow.KEY_DOWN)
        keybow.tap_key("=")
        keybow.set_modifier(meta_key, keybow.KEY_UP)
    end
end

function handle_key_08(pressed) -- Develop view
    keybow.set_key("d", pressed)
end

function handle_key_09(pressed) -- Import
    if pressed then
        keybow.set_modifier(meta_key, keybow.KEY_DOWN)
        keybow.set_modifier(keybow.LEFT_SHIFT, keybow.KEY_DOWN)
        keybow.tap_key("i")
        keybow.set_modifier(meta_key, keybow.KEY_UP)
        keybow.set_modifier(keybow.LEFT_SHIFT, keybow.KEY_UP)
    end
end

function handle_key_10(pressed) -- Zoom out
    if pressed then
        keybow.set_modifier(meta_key, keybow.KEY_DOWN)
        keybow.tap_key("-")
        keybow.set_modifier(meta_key, keybow.KEY_UP)
    end
end

function handle_key_11(pressed) -- Grid view
    keybow.set_key("g", pressed)
end
