require "keybow"

linux_snippets = {}

function modifier(key, ...)
    for i = 1, select('#', ...) do
        local j = select(i, ...)
        keybow.set_modifier(j, keybow.KEY_DOWN)
    end
    keybow.tap_key(key)
    for i = 1, select('#', ...) do
        local j = select(i, ...)
        keybow.set_modifier(j, keybow.KEY_UP)
    end
end

-- General Ubuntu 18.04 with Gnome 3 shortcuts --

function linux_snippets.u_open_terminal()
    modifier("t", keybow.LEFT_CTRL, keybow.LEFT_ALT)
end

function linux_snippets.u_lock_screen()
    modifier("l", keybow.LEFT_META)
end

function linux_snippets.u_show_desktop()
    modifier("d", keybow.LEFT_META)
end

function linux_snippets.u_show_app_menu()
    modifier("a", keybow.LEFT_META)
end

function linux_snippets.u_switch_app()
    modifier(keybow.TAB, keybow.LEFT_ALT)
end

function linux_snippets.u_save()
    modifier("s", keybow.LEFT_CTRL)
end

function linux_snippets.u_snap_window_left()
    modifier(keybow.LEFT_ARROW, keybow.LEFT_META)
end

function linux_snippets.u_snap_window_right()
    modifier(keybow.RIGHT_ARROW, keybow.LEFT_META)
end

function linux_snippets.u_snap_window_full()
    modifier(keybow.UP_ARROW, keybow.LEFT_META)
end

function linux_snippets.u_unsnap_window()
    modifier(keybow.DOWN_ARROW, keybow.LEFT_META)
end

function linux_snippets.u_toggle_notification_tray()
    modifier("m", keybow.LEFT_META)
end

function linux_snippets.u_change_keyboard()
    modifier(keybow.SPACE, keybow.LEFT_META)
end

function linux_snippets.u_run_console()
    modifier(keybow.F2, keybow.LEFT_ALT)
end

function linux_snippets.u_close_app()
    modifier("q", keybow.LEFT_CTRL)
end

function linux_snippets.u_workspace_up()
    modifier(keybow.UP_ARROW, keybow.LEFT_CTRL, keybow.LEFT_ALT)
end

function linux_snippets.u_workspace_down()
    modifier(keybow.DOWN_ARROW, keybow.LEFT_CTRL, keybow.LEFT_ALT)
end

function linux_snippets.u_switch_app_directly()
    modifier(keybow.ESC, keybow.LEFT_ALT)
end

function linux_snippets.u_open_app(place)
    -- opens app in Ubuntu Gnome's sidebar at the place number specified in 'place', 'place' must be a string!
    modifier(place, keybow.LEFT_META)
end

function linux_snippets.u_open_new_instance(place)
    -- opens new instance of app in Ubuntu Gnome's sidebar at the place number specified in 'place', 'place' must be a string!
    modifier(place, keybow.LEFT_META, keybow.LEFT_SHIFT)
end
