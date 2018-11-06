function handle_key_00 (pressed)
    set_key(0x27, pressed)
end

function handle_key_01 (pressed)
    --set_key(0x37, pressed)
    if pressed then
        tap_left_meta()
        sleep(500)
        text("Text Editor")
        sleep(500)
        tap_enter()
    end
end

function handle_key_02 (pressed)
    if pressed then
        text("Hello World")
    else
        text("The quick brown fox jumped over the lazy dog")
    end
end

function handle_key_03 (pressed)
    set_key(0x1e, pressed)
end

function handle_key_04 (pressed)
    set_key(0x1f, pressed)
end

function handle_key_05 (pressed)
    set_key(0x20, pressed)
end

function handle_key_06 (pressed)
    set_key(0x21, pressed)
end

function handle_key_07 (pressed)
    set_key(0x22, pressed)
end

function handle_key_08 (pressed)
    set_key(0x23, pressed)
end

function handle_key_09 (pressed)
    set_key(0x24, pressed)
end

function handle_key_10 (pressed)
    set_key(0x25, pressed)
end

function handle_key_11 (pressed)
    set_key(0x26, pressed)
end
