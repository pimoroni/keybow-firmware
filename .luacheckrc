std = "min"

globals = {
    'keybow'
}

allow_defined = true
codes = true

include_files = {
    "sdcard/snippets/*.lua",
    "sdcard/layouts/*.lua"
}

files["sdcard/snippets/*.lua"] = {ignore = {"131"}}
files["sdcard/layouts/*.lua"] = {ignore = {"131"}}
files["sdcard/layouts/boilerplate.lua"] = {ignore = {"612"}} -- ignore whitespace at end of lipsum
