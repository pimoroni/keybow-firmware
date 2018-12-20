require "keybow"

-- Standard number pad mapping --

-- Key mappings --

function handle_key_00(pressed)
    keybow.set_key("0", pressed)
end

function handle_key_01(pressed)
    keybow.set_key(".", pressed)
end

function handle_key_02(pressed)
    keybow.set_key(keybow.ENTER, pressed)
end

function handle_key_03(pressed)
    keybow.set_key("1", pressed)
end

function handle_key_04(pressed)
    keybow.set_key("2", pressed)
end

function handle_key_05(pressed)
    keybow.set_key("3", pressed)
end

function handle_key_06(pressed)
    keybow.set_key("4", pressed)
end

function handle_key_07(pressed)
    keybow.set_key("5", pressed)
end

function handle_key_08(pressed)
    keybow.set_key("6", pressed)
end

function handle_key_09(pressed)
    keybow.set_key("7", pressed)
end

function handle_key_10(pressed)
    keybow.set_key("8", pressed)
end

function handle_key_11(pressed)
    keybow.set_key("9", pressed)
end
