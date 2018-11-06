function handle_key_00 (state)
    set_key(0x27, state)
end

function handle_key_01 (state)
    set_key(0x37, state)
end

function type_message (message)
    for i = 1, #message do
        hid_code = message:byte(i) - 93
        press_key(hid_code)
        release_key(hid_code)
    end
end

function handle_key_02 (state)
    if state then
        type_message("hello")
    else
        type_message("goodbye")
    end
end

function handle_key_03 (state)
    set_key(0x1e, state)
end

function handle_key_04 (state)
    set_key(0x1f, state)
end

function handle_key_05 (state)
    set_key(0x20, state)
end

function handle_key_06 (state)
    set_key(0x21, state)
end

function handle_key_07 (state)
    set_key(0x22, state)
end

function handle_key_08 (state)
    set_key(0x23, state)
end

function handle_key_09 (state)
    set_key(0x24, state)
end

function handle_key_10 (state)
    set_key(0x25, state)
end

function handle_key_11 (state)
    set_key(0x26, state)
end
