require "keyboards/english" -- Change name of language to change keyboard layout. Available layouts are "belgian_french", "danish", "english" and "norwegian"

keybow = {}

keybow.LEFT_CTRL = 0
keybow.LEFT_SHIFT = 1
keybow.LEFT_ALT = 2
keybow.LEFT_META = 3

keybow.RIGHT_CTRL = 4
keybow.RIGHT_SHIFT = 5
keybow.RIGHT_ALT = 6
keybow.RIGHT_META = 7

keybow.ENTER = 0x28
keybow.ESC = 0x29
keybow.BACKSPACE = 0x2a
keybow.TAB = 0x2b
keybow.SPACE = 0x2c
keybow.CAPSLOCK = 0x39

keybow.LEFT_ARROW = 0x50
keybow.RIGHT_ARROW = 0x4f
keybow.UP_ARROW = 0x52
keybow.DOWN_ARROW = 0x51

keybow.INSERT = 0x49
keybow.HOME = 0x4a
keybow.DELETE = 0x4c
keybow.END = 0x4d
keybow.PAGEUP = 0x4b
keybow.PAGEDOWN = 0x4e

keybow.F1 = 0x3a
keybow.F2 = 0x3b
keybow.F3 = 0x3c
keybow.F4 = 0x3d
keybow.F5 = 0x3e
keybow.F6 = 0x3f
keybow.F7 = 0x40
keybow.F8 = 0x41
keybow.F9 = 0x42
keybow.F10 = 0x43
keybow.F11 = 0x44
keybow.F12 = 0x45

keybow.F13 = 0x68
keybow.F14 = 0x69
keybow.F15 = 0x6a
keybow.F16 = 0x6b
keybow.F17 = 0x6c
keybow.F18 = 0x6d
keybow.F19 = 0x6e
keybow.F20 = 0x6f
keybow.F21 = 0x70
keybow.F22 = 0x71
keybow.F23 = 0x72
keybow.F24 = 0x73

keybow.KEY_DOWN = true
keybow.KEY_UP = false

keybow.MEDIA_NEXT = 0
keybow.MEDIA_PREV = 1
keybow.MEDIA_STOP = 2
keybow.MEDIA_EJECT = 3
keybow.MEDIA_PLAYPAUSE=  4
keybow.MEDIA_MUTE = 5
keybow.MEDIA_VOL_UP = 6
keybow.MEDIA_VOL_DOWN = 7

keybow.MOUSE_LMB = 0
keybow.MOUSE_RMB = 1
keybow.MOUSE_MMB = 2

-- Functions exposed from C

function keybow.set_modifier(key, state)
    keybow_set_modifier(key, state)
end

function keybow.set_media_key(key, state)
    keybow_set_media_key(key, state)
end

function keybow.set_mouse_button(button, state)
    keybow_set_mousebutton(button, state)
end

function keybow.set_mouse_movement(x, y)
    keybow_set_mousemove(x, y)
end

function keybow.sleep(time)
    keybow_sleep(time)
end

function keybow.usleep(time)
    keybow_usleep(time)
end

function keybow.ascii_text(text)
    for i = 1, #text do        
        local c = text:sub(i, i)
        keybow.tap_key(c)
    end

    keybow.set_modifier(keybow.RIGHT_ALT, false)
    keybow.set_modifier(keybow.LEFT_SHIFT, false)
end

function keybow.text(text)
    for uchar in string.gmatch(text, "([%z\1-\127\194-\244][\128-\191]*)") do
        keybow.tap_key(uchar)
    end

    keybow.set_modifier(keybow.RIGHT_ALT, false)
    keybow.set_modifier(keybow.LEFT_SHIFT, false)
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

-- Meta keys - ctrl, shift, alt and win/apple

function keybow.tap_left_ctrl()
    keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_CTRL, keybow.KEY_UP)
end

function keybow.tap_right_ctrl()
    keybow.set_modifier(keybow.RIGHT_CTRL, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.RIGHT_CTRL, keybow.KEY_UP)
end

function keybow.tap_left_shift()
    keybow.set_modifier(keybow.LEFT_SHIFT, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_SHIFT, keybow.KEY_UP)
end

function keybow.tap_right_shift()
    keybow.set_modifier(keybow.RIGHT_SHIFT, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.RIGHT_SHIFT, keybow.KEY_UP)
end

function keybow.tap_left_alt()
    keybow.set_modifier(keybow.LEFT_ALT, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_ALT, keybow.KEY_UP)
end

function keybow.tap_right_alt()
    keybow.set_modifier(keybow.RIGHT_ALT, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.RIGHT_ALT, keybow.KEY_UP)
end

function keybow.tap_left_meta()
    keybow.set_modifier(keybow.LEFT_META, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.LEFT_META, keybow.KEY_UP)
end

function keybow.tap_right_meta()
    keybow.set_modifier(keybow.RIGHT_META, keybow.KEY_DOWN)
    keybow.set_modifier(keybow.RIGHT_META, keybow.KEY_UP)
end

-- Function keys

function keybow.tap_function_key(index)
    index = 57 + index -- Offset to 0x39 (F1 is 0x3a)
    keybow.set_key(index, true)
    keybow.set_key(index, false)
end

function keybow.ascii_to_shift(key)
    if not (type(key) == "string") then
        return false
    end
    
    return SHIFTED_KEYCODES.find(key) ~= nil
end

function keybow.ascii_to_hid(key)
    if not (type(key) == "string") then
        return key
    end

    key = key:lower()

    code = KEYCODES:find(key)
    
    if code == nil then return nil end

    return code + 3
end

function keybow.find_keycode(keycode_map, keycode)
    for k, v in ipairs(keycode_map) do
        if v == keycode then return k end
    end
    return nil
end

function keybow.set_key(key, pressed)
    if type(key) == "string" then
        local normal = keybow.find_keycode(KEYCODES, key)
        local shifted = keybow.find_keycode(SHIFTED_KEYCODES, key)
        local altgred = keybow.find_keycode(ALTGRD_KEYCODES, key)
        local shiftaltgred = keybow.find_keycode(SHIFTALTGRD_KEYCODES, key)

        local hid_code = shiftaltgred or shifted or altgred or normal

        if shiftaltgred then
            shifted = true
            altgred = true
        end

        if not (hid_code == nil) then
            hid_code = hid_code + 3
            if shifted then keybow.set_modifier(keybow.LEFT_SHIFT, pressed) end
            if altgred then keybow.set_modifier(keybow.RIGHT_ALT, pressed) end
            keybow_set_key(hid_code, pressed)
        end

    else -- already a key code
        keybow_set_key(key, pressed)
    end
end

function keybow.tap_enter()
    keybow.set_key(keybow.ENTER, true)
    keybow.set_key(keybow.ENTER, false)
end

function keybow.tap_space()
    keybow.set_key(keybow.SPACE, true)
    keybow.set_key(keybow.SPACE, false)
end

function keybow.tap_shift()
    keybow.set_key(keybow.LEFT_SHIFT, true)
    keybow.set_key(keybow.LEFT_SHIFT, false)
end

function keybow.tap_tab()
    keybow.set_key(keybow.TAB, true)
    keybow.set_key(keybow.TAB, false)
end

function keybow.tap_key(key)
    keybow.set_key(key, true)
    keybow.set_key(key, false)
end

function keybow.press_key(key)
    keybow.set_key(key, true)
end

function keybow.release_key(key)
    keybow.set_key(key, false)
end

-- MIDI

function keybow.send_midi_note(channel, note, velocity, pressed)
    keybow_send_midi_note(channel, note, velocity, pressed)
end

-- Keybow Mini

function keybow.use_mini()
    keybow.set_pixel = function(x, r, g, b)
	leds = {[0] = 3, [1] = 6, [2] = 9}
	x = leds[x]
	if x ~= nil then
            keybow_set_pixel(x, r, g, b)
        end
    end
    _G.handle_key_00 = function(pressed)
        handle_minikey_00(pressed)
    end
    _G.handle_key_03 = function(pressed)
        handle_minikey_01(pressed)
    end
    _G.handle_key_06 = function(pressed)
        handle_minikey_02(pressed)
    end
end
