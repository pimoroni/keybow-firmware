keybow = {}

keybow.LEFT_CTRL = 0
keybow.LEFT_SHIFT = 1
keybow.LEFT_ALT = 2
keybow.LEFT_META = 3

keybow.RIGHT_CTRL = 4
keybow.RIGHT_SHIFT = 5
keybow.RIGHT_ALT = 6
keybow.RIGHT_META = 7

keybow.KEY_DOWN = 1
keybow.KEY_UP = 0

-- Functions exposed from C

function keybow.set_key(key, state)
    keybow_set_key(key, state)
end

function keybow.set_modifier(key, state)
    keybow_set_modifier(key, state)
end

function keybow.sleep(time)
    keybow_sleep(time)
end

function keybow.usleep(time)
    keybow_usleep(time)
end

function keybow.text(text)
    print("Text: " .. text)
    keybow_text(text)
end

-- Lighting control

function keybow.set_pixel(x, r, g, b)
    keybow_set_pixel(x, r, g, b)
end

function keybow.auto_lights(state)
    keybow_auto_lights(state)
end

function keybow.clear_lights()
    keybow_clear_lights()
end

function keybow.load_pattern(file)
    keybow_load_pattern(file)
end

-- Convinience functions

function keybow.tap_left_ctrl()
    keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_UP)
end

function keybow.tap_right_ctrl()
    keybow.set_modifier(keybow.RIGHT_CTRL, keybow.KEY_DOWN)
    keybow.set_modifier(KEYBOW.RIGHT_CTRL, keybow.KEY_UP)
end

function keybow.tap_left_shift()
    keybow.set_modifier(keybow.LEFT_SHIFT, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_SHIFT, keybow.KEY_UP)
end

function keybow.tap_right_shift()
    keybow.set_modifier(keybow.RIGHT_SHIFT, keybow.KEY_DOWN)
    keybow.set_modifier(KEYBOW.RIGHT_SHIFT, keybow.KEY_UP)
end

function keybow.tap_left_alt()
    keybow.set_modifier(keybow.LEFT_ALT, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_ALT, keybow.KEY_UP)
end

function keybow.tap_right_alt()
    keybow.set_modifier(keybow.RIGHT_ALT, keybow.KEY_DOWN)
    keybow.set_modifier(KEYBOW.RIGHT_ALT, keybow.KEY_UP)
end

function keybow.tap_left_meta()
    keybow.set_modifier(keybow.LEFT_META, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_META, keybow.KEY_UP)
end

function keybow.tap_right_meta()
    keybow.set_modifier(keybow.RIGHT_META, keybow.KEY_DOWN)
    keybow.set_modifier(KEYBOW.RIGHT_META, keybow.KEY_UP)
end

function keybow.tap_enter()
    keybow.set_key(0x28, true)
    keybow.set_key(0x28, false)
end

function keybow.tap_space()
    keybow.set_key(0x2c, true)
    keybow.set_key(0x2c, false)
end

function keybow.ascii_to_hid(key)
    key = key:lower()
    key = key:byte(1)
    if key == 48 then return 39 end -- 0
    if key == 32 then return 44 end -- SPACE
    if key >= 49 and key <= 57 then -- 1 to 9
        return key - 19
    end
    if key >= 97 and key <= 122 then
	return key - 93
    end
    return nil
end

function keybow.tap_key(key)
    key = keybow.ascii_to_hid(key)
    if key then
        keybow.set_key(key, true)
        keybow.set_key(key, false)
    end
end

function keybow.set_key(key, pressed)
    if type(key) == "string" then
        key = keybow.ascii_to_hid(key)
    end
    if key then
        keybow_set_key(key, pressed)
    end
end

function keybow.press_key(key)
    keybow.set_key(key, true)
end

function keybow.release_key(key)
    keybow.set_key(key, false)
end
