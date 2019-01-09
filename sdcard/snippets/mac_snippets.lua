require "keybow"

mac_snippets = {}

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

-- General macOS shortcuts --

function mac_snippets.new_document()
    modifier("n", keybow.LEFT_META)
    keybow.sleep(500)
end

function mac_snippets.save()
    modifier("s", keybow.LEFT_META)
end

function mac_snippets.quit_app()
    modifier("q", keybow.LEFT_META)
end

function mac_snippets.spotlight(command)
    modifier(keybow.SPACE, keybow.LEFT_META)
    keybow.sleep(500)
    keybow.text(command)
    keybow.sleep(500)
    keybow.tap_enter()
    keybow.sleep(500)
end

function mac_snippets.search(term)
    modifier("f", keybow.LEFT_META)
    keybow.sleep(500)
    keybow.text(term)
    keybow.sleep(500)
    keybow.tap_enter()
end

function mac_snippets.emoji_picker()
    modifier(keybow.SPACE, keybow.LEFT_CTRL, keybow.LEFT_META)
end

-- View shortcuts --

function mac_snippets.switch_app()
    modifier(keybow.TAB, keybow.LEFT_META)
end

function mac_snippets.next_space()
    modifier(keybow.RIGHT_ARROW, keybow.LEFT_CTRL)
end

function mac_snippets.prev_space()
    modifier(keybow.LEFT_ARROW, keybow.LEFT_CTRL)
end

function mac_snippets.mission_control()
    modifier(keybow.UP_ARROW, keybow.LEFT_CTRL)
end

function mac_snippets.desktop()
    keybow.tap_key(keybow.F11)
end

function mac_snippets.current_app_windows()
    modifier(keybow.DOWN_ARROW, keybow.LEFT_CTRL)
end

function mac_snippets.zoom_in()
    modifier("+", keybow.LEFT_META)
end

function mac_snippets.zoom_out()
    modifier("-", keybow.LEFT_META)
end

-- Finder shortcuts --

function mac_snippets.open_finder()
	mac_snippets.spotlight("finder")
end

function mac_snippets.finder_inspect()
    modifier("i", keybow.LEFT_META, keybow.LEFT_ALT)
end

function mac_snippets.soft_delete()
    modifier(keybow.BACKSPACE, keybow.LEFT_META)
end

function mac_snippets.hard_delete()
    modifier(keybow.BACKSPACE, keybow.LEFT_META, keybow.LEFT_ALT)
end

function mac_snippets.empty_bin()
    modifier(keybow.BACKSPACE, keybow.LEFT_META, keybow.LEFT_SHIFT)
end

function mac_snippets.hard_empty_bin()
    modifier(keybow.BACKSPACE, keybow.LEFT_META, keybow.LEFT_ALT, keybow.LEFT_SHIFT)
end

-- Screenshot shortcuts --

function mac_snippets.screenshot()
    modifier("5", keybow.LEFT_META, keybow.LEFT_SHIFT)
end

function mac_snippets.screenshot_screen()
    modifier("3", keybow.LEFT_META, keybow.LEFT_SHIFT)
end

function mac_snippets.screenshot_selection()
    modifier("4", keybow.LEFT_META, keybow.LEFT_SHIFT)
end

function mac_snippets.screenshot_window()
    modifier("4", keybow.LEFT_META, keybow.LEFT_SHIFT)
    keybow.tap_space()
end

-- Safari shortcuts --

function mac_snippets.next_safari_tab()
    modifier(keybow.TAB, keybow.LEFT_CTRL)
end

function mac_snippets.prev_safari_tab()
    modifier(keybow.TAB, keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
end

function mac_snippets.reopen_safari_tab()
    modifier("t", keybow.LEFT_META, keybow.LEFT_SHIFT)
end

function mac_snippets.safari_search(term)
    modifier("l", keybow.LEFT_META)
    keybow.sleep(500)
    keybow.text(term)
    keybow.sleep(500)
    keybow.tap_enter()
end

-- Mail shortcuts --

function mac_snippets.new_mail()
	mac_snippets.spotlight("mail")
	mac_snippets.new_document()
    keybow.sleep(500)
end

function mac_snippets.send_mail()
	modifier("d", keybow.LEFT_META, keybow.LEFT_SHIFT)
end

function mac_snippets.reply_mail()
	modifier("r", keybow.LEFT_META)
end
