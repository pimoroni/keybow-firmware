require "keybow"

-- Extended numberpad with light feedback --
-- key 0 (bottom left) used as modifier (shift) key
-- -- key 1 produces zero, or a dot (.) with the modifier pressed down
-- -- key 2: TAB, or ENTER with the modifier
-- -- keys 4, 6, 8, 10: arrow down, left, right, up

function setup()
    keybow.auto_lights(false)
    keybow.clear_lights()
    keybow.set_pixel(0, 20, 20, 20)
end

-- Key mappings --

-- we set our own internal modifier variable;
-- this has nothing to do with sending out a "modifier key pressed signal"
modifier = false

function handle_key_00(pressed)
    if pressed then
        modifier = true
        keybow.set_pixel(1, 255, 255, 255)
        keybow.set_pixel(2, 255, 255, 255)
        keybow.set_pixel(4, 255, 0, 0)
        keybow.set_pixel(6, 255, 0, 0)
        keybow.set_pixel(8, 255, 0, 0)
        keybow.set_pixel(10, 255, 0, 0)
    else
        modifier = false
        keybow.set_pixel(0, 0, 0, 0)
        keybow.set_pixel(1, 0, 0, 0)
        keybow.set_pixel(2, 0, 0, 0)
        keybow.set_pixel(4, 0, 0, 0)
        keybow.set_pixel(6, 0, 0, 0)
        keybow.set_pixel(8, 0, 0, 0)
        keybow.set_pixel(10, 0, 0, 0)
    end
end

function handle_key_01(pressed)
    local pix = 1
    if modifier == true then
        keybow.set_key(".", pressed)
    else
        keybow.set_key("0", pressed)
    end

    if pressed then
        if modifier == true then
            keybow.set_pixel(pix, 0, 0, 0)
        else
            keybow.set_pixel(pix, 255, 255, 255)
        end
    else
        keybow.release_key(".")
        keybow.release_key("0")
        if modifier == true then
            keybow.set_pixel(pix, 255, 255, 255)
        else
            keybow.set_pixel(pix, 0, 0, 0)
        end
    end
end

function handle_key_02(pressed)
    local pix = 2
    if modifier == true then
        keybow.set_key(keybow.ENTER, pressed)
    else
        keybow.set_key(keybow.TAB, pressed)
    end

    if pressed then
        if modifier == true then
            keybow.set_pixel(pix, 0, 0, 0)
        else
            keybow.set_pixel(pix, 255, 255, 255)
        end
    else
        keybow.release_key(keybow.ENTER)
        keybow.release_key(keybow.TAB)
        if modifier == true then
            keybow.set_pixel(pix, 255, 255, 255)
        else
            keybow.set_pixel(pix, 0, 0, 0)
        end
    end
end

function handle_key_03(pressed)
    local pix = 3
    keybow.set_key("1", pressed)
    if pressed then
        keybow.set_pixel(pix, 255, 255, 255)
    else
        keybow.set_pixel(pix, 0, 0, 0)
    end
end

function handle_key_04(pressed)
    local pix = 4
    if modifier == true then
        keybow.set_key(keybow.DOWN_ARROW, pressed)
    else
        keybow.set_key("2", pressed)
    end

    if pressed then
        if modifier == true then
            keybow.set_pixel(pix, 0, 0, 0)
        else
            keybow.set_pixel(pix, 255, 255, 255)
        end
    else
        keybow.release_key(keybow.DOWN_ARROW)
        keybow.release_key("2")
        if modifier == true then
            keybow.set_pixel(pix, 255, 0, 0)
        else
            keybow.set_pixel(pix, 0, 0, 0)
        end
    end
end

function handle_key_05(pressed)
    local pix = 5
    keybow.set_key("3", pressed)
    if pressed then
        keybow.set_pixel(pix, 255, 255, 255)
    else
        keybow.set_pixel(pix, 0, 0, 0)
    end
end

function handle_key_06(pressed)
    local pix = 6
    if modifier == true then
        keybow.set_key(keybow.LEFT_ARROW, pressed)
    else
        keybow.set_key("4", pressed)
    end

    if pressed then
        if modifier == true then
            keybow.set_pixel(pix, 0, 0, 0)
        else
            keybow.set_pixel(pix, 255, 255, 255)
        end
    else
        keybow.release_key(keybow.LEFT_ARROW)
        keybow.release_key("4")
        if modifier == true then
            keybow.set_pixel(pix, 255, 0, 0)
        else
            keybow.set_pixel(pix, 0, 0, 0)
        end
    end
end

function handle_key_07(pressed)
    local pix = 7
    keybow.set_key("5", pressed)
    if pressed then
        keybow.set_pixel(pix, 255, 255, 255)
    else
        keybow.set_pixel(pix, 0, 0, 0)
    end
end

function handle_key_08(pressed)
    local pix = 8
    if modifier == true then
        keybow.set_key(keybow.RIGHT_ARROW, pressed)
    else
        keybow.set_key("6", pressed)
    end

    if pressed then
        if modifier == true then
            keybow.set_pixel(pix, 0, 0, 0)
        else
            keybow.set_pixel(pix, 255, 255, 255)
        end
    else
        keybow.release_key(keybow.RIGHT_ARROW)
        keybow.release_key("6")
        if modifier == true then
            keybow.set_pixel(pix, 255, 0, 0)
        else
            keybow.set_pixel(pix, 0, 0, 0)
        end
    end
end

function handle_key_09(pressed)
    local pix = 9
    keybow.set_key("7", pressed)
    if pressed then
        keybow.set_pixel(pix, 255, 255, 255)
    else
        keybow.set_pixel(pix, 0, 0, 0)
    end
end

function handle_key_10(pressed)
    local pix = 10
    if modifier == true then
        keybow.set_key(keybow.UP_ARROW, pressed)
    else
        keybow.set_key("8", pressed)
    end

    if pressed then
        if modifier == true then
            keybow.set_pixel(pix, 0, 0, 0)
        else
            keybow.set_pixel(pix, 255, 255, 255)
        end
    else
        keybow.release_key(keybow.UP_ARROW)
        keybow.release_key("8")
        if modifier == true then
            keybow.set_pixel(pix, 255, 0, 0)
        else
            keybow.set_pixel(pix, 0, 0, 0)
        end
    end
end

function handle_key_11(pressed)
    local pix = 11
    keybow.set_key("9", pressed)
    if pressed then
        keybow.set_pixel(pix, 255, 255, 255)
    else
        keybow.set_pixel(pix, 0, 0, 0)
    end
end
