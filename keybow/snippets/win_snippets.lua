require "keybow"

win_snippets = {}

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

-- General Windows shortcuts --

function win_snippets.start_menu()
	keybow.tap_left_meta()
end

function win_snippets.run(command)
	modifier("r", keybow.LEFT_META)
	keybow.sleep(500)
    keybow.text(command)
    keybow.sleep(500)
    keybow.tap_enter()
    keybow.sleep(500)
end

function win_snippets.search(term)
	modifier("s", keybow.LEFT_META)
	keybow.sleep(500)
    keybow.text(term)
    keybow.sleep(500)
    keybow.tap_enter()
    keybow.sleep(500)
end

function win_snippets.cortana()
	modifier("c", keybow.LEFT_META)
end

function win_snippets.task_manager()
	modifier(keybow.ESC, keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
end

function win_snippets.new()
	modifier("n", keybow.LEFT_CTRL)
end

function win_snippets.save()
    modifier("s", keybow.LEFT_CTRL)
end

function win_snippets.find()
	modifier("f", keybow.LEFT_CTRL)
end

function win_snippets.quit_app()
	modifier(keybow.F4, keybow.LEFT_CTRL)
end

-- View shortcuts --

function win_snippets.switch_app()
    modifier(keybow.TAB, keybow.LEFT_ALT)
end

function win_snippets.desktop()
	modifier("d", keybow.LEFT_META)
end

function win_snippets.peek_desktop()
	modifier(",", keybow.LEFT_META)
end

function win_snippets.snap_left()
	modifier(keybow.LEFT_ARROW, keybow.LEFT_META)
end

function win_snippets.snap_right()
	modifier(keybow.RIGHT_ARROW, keybow.LEFT_META)
end

function win_snippets.zoom_in()
    modifier("+", keybow.LEFT_META)
end

function win_snippets.zoom_out()
    modifier("-", keybow.LEFT_META)
end

-- Explorer shortcuts --

function win_snippets.explorer()
	modifier("e", keybow.LEFT_META)
end

-- Chrome shortcuts --

function win_snippets.chrome_search(term)
    modifier("k", keybow.LEFT_CTRL)
    keybow.sleep(500)
    keybow.text(term)
    keybow.sleep(500)
    keybow.tap_enter()
end

function win_snippets.chrome_history()
	modifier("h", keybow.LEFT_CTRL)
end

function win_snippets.chrome_bookmark()
	modifier("d", keybow.LEFT_CTRL)
end

function win_snippets.chrome_downloads()
	modifier("j", keybow.LEFT_CTRL)
end

function win_snippets.reopen_chrome_tab()
    modifier("t", keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
end

function win_snippets.chrome_console()
	modifier("c", keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
end

-- Outlook shortcuts --

function win_snippets.new_mail()
	win_snippets.run("outlook")
	modifier("m", keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
end

function win_snippets.send_mail()
	modifier("s", keybow.LEFT_ALT)
end

function win_snippets.reply_mail()
	modifier("r", keybow.LEFT_CTRL)
end
