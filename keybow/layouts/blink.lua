require "keybow"

-- Standard numberpad with light feedback --

function setup()
    keybow.auto_lights(false)
    keybow.clear_lights()
end

-- Standard number pad mapping --

-- Key mappings --

function handle_key_00(pressed)
    keybow.set_key("0", pressed)
    if pressed then
        keybow.set_pixel(0, 255, 255, 255)
    else
        keybow.set_pixel(0, 0, 0, 0)
    end
end

function handle_key_01(pressed)
    keybow.set_key(".", pressed)
    if pressed then
        keybow.set_pixel(1, 255, 255, 255)
    else
        keybow.set_pixel(1, 0, 0, 0)
    end
end

function handle_key_02(pressed)
    keybow.set_key(keybow.ENTER, pressed)
    if pressed then
        keybow.set_pixel(2, 255, 255, 255)
    else
        keybow.set_pixel(2, 0, 0, 0)
    end
end

function handle_key_03(pressed)
    keybow.set_key("1", pressed)
    if pressed then
        keybow.set_pixel(3, 255, 255, 255)
    else
        keybow.set_pixel(3, 0, 0, 0)
    end
end

function handle_key_04(pressed)
    keybow.set_key("2", pressed)
    if pressed then
        keybow.set_pixel(4, 255, 255, 255)
    else
        keybow.set_pixel(4, 0, 0, 0)
    end
end

function handle_key_05(pressed)
    keybow.set_key("3", pressed)
    if pressed then
        keybow.set_pixel(5, 255, 255, 255)
    else
        keybow.set_pixel(5, 0, 0, 0)
    end
end

function handle_key_06(pressed)
    keybow.set_key("4", pressed)
    if pressed then
        keybow.set_pixel(6, 255, 255, 255)
    else
        keybow.set_pixel(6, 0, 0, 0)
    end
end

function handle_key_07(pressed)
    keybow.set_key("5", pressed)
    if pressed then
        keybow.set_pixel(7, 255, 255, 255)
    else
        keybow.set_pixel(7, 0, 0, 0)
    end
end

function handle_key_08(pressed)
    keybow.set_key("6", pressed)
    if pressed then
        keybow.set_pixel(8, 255, 255, 255)
    else
        keybow.set_pixel(8, 0, 0, 0)
    end
end

function handle_key_09(pressed)
    keybow.set_key("7", pressed)
    if pressed then
        keybow.set_pixel(9, 255, 255, 255)
    else
        keybow.set_pixel(9, 0, 0, 0)
    end
end

function handle_key_10(pressed)
    keybow.set_key("8", pressed)
    if pressed then
        keybow.set_pixel(10, 255, 255, 255)
    else
        keybow.set_pixel(10, 0, 0, 0)
    end
end

function handle_key_11(pressed)
    keybow.set_key("9", pressed)
    if pressed then
        keybow.set_pixel(11, 255, 255, 255)
    else
        keybow.set_pixel(11, 0, 0, 0)
    end
end
