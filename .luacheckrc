std = "min"

globals = {
    'keybow'
}

allow_defined = true
unused = false
codes = true

include_files = {
    "sdcard/snippets/*.lua",
    "sdcard/layouts/*.lua"
}

files["sdcard/snippets/*.lua"] = {ignore = {"131"}}
files["sdcard/layouts/*.lua"] = {ignore = {"131"}}
