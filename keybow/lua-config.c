#include "lua-config.h"
#include "lights.h"
#include "keybow.h"
#include "gadget-hid.h"

int isPressed(unsigned short hid_code){
    int x;
    for(x = 0; x < 14; x++){
        if(pressed_keys[x] == hid_code){
            return 1;
        }
    }
    return 0;
}

int releaseKey(unsigned short hid_code){
    int x;
    for(x = 0; x < 14; x++){
        if(pressed_keys[x] == hid_code){
            pressed_keys[x] = 0;
            return 1;
        }
    }
    return 0;
}

void pressKey(unsigned short hid_code){
    int x;
    for(x = 0; x < 14; x++){
        if(pressed_keys[x] == 0){
            pressed_keys[x] = hid_code;
            return;
        }
    }

    // No empty slot found
}

void sendHIDReport(){
    int x;
    unsigned char buf[16];
    buf[0] = modifiers;
    buf[1] = 0;
    for(x = 2; x < 16; x++){
        buf[x] = pressed_keys[x-2];
    }
    write(hid_output, buf, HID_REPORT_SIZE);
    usleep(1000);
}

int toggleModifier(unsigned short modifier) {
    if(modifiers & (1 << modifier)){
        modifiers &= ~(1 << modifier);
    }
    else
    {
        modifiers |= (1 << modifier);
    }
    sendHIDReport();
}

static int l_usleep(lua_State *L) {
    int t = luaL_checknumber(L, 1);
    usleep(t);
}

static int l_sleep(lua_State *L) {
    int t = luaL_checknumber(L, 1);
    usleep(t * 1000);
}

static int l_get_modifier(lua_State *L) {
    unsigned short index = luaL_checknumber(L, 1);
    unsigned short current = (modifiers & (1 << index)) > 0;
    lua_pushboolean(L, current);
    return 1;
}

static int l_set_modifier(lua_State *L) {
    unsigned short index = luaL_checknumber(L, 1);
    unsigned short state = lua_toboolean(L, 2);

    unsigned short current = (modifiers & (1 << index)) > 0;
    if(current != state){
        modifiers &= ~(1 << index);
        modifiers |= (state << index);
        printf("Modifier %d set to %d\n", index, state);
        sendHIDReport();
    }

    lua_pushboolean(L, current != state);
    return 1;
}

static int l_send_text(lua_State *L) {
    size_t length;
    const char *message = luaL_checklstring(L, 1, &length);
    int x = 0;
    for(x = 0; x < length; x++){
        int hid_code = 0;
        int shift = 0;
        int code = message[x];
        if (code == 48){hid_code = 39;}
        if (code == 32){hid_code = 44;}
        if (code >= 49 && code <= 57){
            hid_code = code - 19;
        }
        if (code >= 65 && code <= 90){
            hid_code = code - 61;
            shift = 1;
        }
        if (code >= 97 && code <= 122){
            hid_code = code - 93;
        }
        if (hid_code != 0){
            if(shift) toggleModifier(1);
            pressKey(hid_code);
            sendHIDReport();       
            releaseKey(hid_code);
            sendHIDReport();
            if(shift) toggleModifier(1);
        }
    }
    return 0;
}

static int l_auto_lights(lua_State *L) {
    unsigned short state = lua_toboolean(L, 1);
    lights_auto = state;
    return 0;
}

static int l_clear_lights(lua_State *L) {
    lights_setAll(0, 0, 0);
    return 0;
}

static int l_set_pixel(lua_State *L) {
    unsigned short x = luaL_checknumber(L, 1);
    unsigned short r = luaL_checknumber(L, 2);
    unsigned short g = luaL_checknumber(L, 3);
    unsigned short b = luaL_checknumber(L, 4);

    keybow_key key = get_key(x);
    x = key.led_index;

    lights_setPixel(x, r, g, b);
}

static int l_set_key(lua_State *L) {
    unsigned short hid_code = luaL_checknumber(L, 1);
    unsigned short state = lua_toboolean(L, 2);
    printf("l_set_key %02x %d\n", hid_code, state);
    if(state){
        if(!isPressed(hid_code)){
            pressKey(hid_code);
            lua_pushboolean(L, 1);
            sendHIDReport();
            return 1;
        }
    }
    else {
        if(releaseKey(hid_code)){
            lua_pushboolean(L, 1);
            sendHIDReport();
            return 1;
        }
    }

    lua_pushboolean(L, 0);
    return 1;
}

static int l_load_pattern(lua_State *L) {
    size_t length;
    const char *pattern = luaL_checklstring(L, 1, &length);

    char filename[length + 10];
    sprintf(filename, "%s.png", pattern);

    pthread_mutex_lock(&lights_mutex);
    int result = read_png_file(filename);
    pthread_mutex_unlock(&lights_mutex);
    
    lua_pushboolean(L, result == 0);

    return 1;
}

int initLUA() {
    modifiers = 0;

    L = luaL_newstate();
    luaL_openlibs(L);

    lua_pushcfunction(L, l_set_pixel);
    lua_setglobal(L, "keybow_set_pixel");

    lua_pushcfunction(L, l_auto_lights);
    lua_setglobal(L, "keybow_auto_lights");

    lua_pushcfunction(L, l_clear_lights);
    lua_setglobal(L, "keybow_clear_lights");

    lua_pushcfunction(L, l_load_pattern);
    lua_setglobal(L, "keybow_load_pattern");

    lua_pushcfunction(L, l_set_key);
    lua_setglobal(L, "keybow_set_key");

    lua_pushcfunction(L, l_send_text);
    lua_setglobal(L, "keybow_text");

    lua_pushcfunction(L, l_sleep);
    lua_setglobal(L, "keybow_sleep");

    lua_pushcfunction(L, l_usleep);
    lua_setglobal(L, "keybow_usleep");

    lua_pushcfunction(L, l_set_modifier);
    lua_setglobal(L, "keybow_set_modifier");
  
    int status;
    status = luaL_loadfile(L, "keys.lua");
    if(status) {
        printf("Couldn't load keys.lua: %s\n", lua_tostring(L, -1));
        return 1;
    }
    status = lua_pcall(L, 0, LUA_MULTRET, 0);
    if(status) {
        printf("Runtime Error: %s\n", lua_tostring(L, -1));
    }

    return 0;
}

void luaCallSetup(void) {
    lua_getglobal(L, "setup");
    if(lua_isfunction(L, lua_gettop(L))){
        if(lua_pcall(L, 0, 0, 0) != 0){
            error(L, "error running function `setup`: %s", lua_tostring(L, -1));
        }
    }
}

int luaHandleKey(unsigned short key_index, unsigned short key_state) {
    char fn[14];
    sprintf(fn, "handle_key_%02d\0", key_index);
    //printf("Calling: %s\n", fn);
    lua_getglobal(L, fn);
    if(lua_isfunction(L, lua_gettop(L))){
        lua_pushboolean(L, key_state); // State
        if (lua_pcall(L, 1, 0, 0) != 0){
            error(L, "error running function `handle_key`: %s", lua_tostring(L, -1));
        }
    } else {
        printf("handle_key_%02d is not defined!\n");
        return 1;
    }
}

void luaClose(void){
    int x;
    modifiers = 0;
    for(x = 0; x < 14; x++){
        pressed_keys[x] = 0;        
    }
    lua_close(L);
    sendHIDReport();
}
