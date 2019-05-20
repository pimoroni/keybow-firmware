require "keybow"

-- Media controls --

-- Key mappings --

function handle_key_00(pressed)
    keybow.set_media_key(keybow.MEDIA_VOL_UP, pressed)
end

function handle_key_01(pressed)
    keybow.set_media_key(keybow.MEDIA_MUTE, pressed)
end

function handle_key_02(pressed)
    keybow.set_media_key(keybow.MEDIA_VOL_DOWN, pressed)
end

function handle_key_03(pressed)
    keybow.set_media_key(keybow.MEDIA_PREV, pressed)
end

function handle_key_04(pressed)
    keybow.set_media_key(keybow.MEDIA_PLAYPAUSE, pressed)
end

function handle_key_05(pressed)
    keybow.set_media_key(keybow.MEDIA_NEXT, pressed)
end

function handle_key_06(pressed)
    keybow.set_media_key(keybow.MEDIA_STOP, pressed)
end

function handle_key_07(pressed)
    keybow.set_media_key(keybow.MEDIA_EJECT, pressed)
end

function handle_key_08(pressed)
end

function handle_key_09(pressed)
end

function handle_key_10(pressed)
end

function handle_key_11(pressed)
end
