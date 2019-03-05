require "keybow"

golang_snippets = {}

function golang_snippets.append()
    keybow.text("append(slice, value)")
end

function golang_snippets.break_keyword()
    keybow.text("break")
end

function golang_snippets.continue_keyword()
    keybow.text("continue")
end

function golang_snippets.defer_keyword()
    keybow.text("defer")
end

function golang_snippets.if_block()
    keybow.text("if stuff {
    do stuff
}")
end

function golang_snippets.check_error_return()
    keybow.text("if err != nil {
    return err
}")
end

function golang_snippets.check_error_log_fatal()
    keybow.text("if err != nil {
    log.Fatal(err)
}")
end

function golang_snippets.check_error_log_panic()
    keybow.text("if err != nil {
    log.Panic(err)
}")
end

function golang_snippets.json_field_tag()
    keybow.text("json:")
end

function golang_snippets.json_field_tag_omitempty()
    keybow.text("json:\"NAME,omitempty\"")
end

function golang_snippets.defer_recover()
    keybow.text("defer func() {
    if err := recover(); err != nil {
        dosomething()
    }
}()")
end

function golang_snippets.for_loop_range_map()
    keybow.text("for k, v := range NAME {
    doSomething()
}")
end

-- Log functions take a level in the Golang standard lib notation
-- i.e. 'Debug' or 'Error'
function golang_snippets.log(level)
    keybow.text("log." .. level .. "()")
end

function golang_snippets.log_ln(level)
    keybow.text("log." .. level .. "ln()")
end

function golang_snippets.log_f(level)
    keybow.text("log." .. level .. "f()")
end

-- Print functions take a mode that can be empty, 'ln' or 'f'
function golang_snippets.print(mode)
    keybow.text("fmt.Print" .. mode .. "()")
end
