#include "lua-config.h"
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

static int l_left_ctrl(lua_State *L) {
    lua_pushboolean(L, toggleModifier(0));
    return 1;
}

static int l_left_shift(lua_State *L) {
    lua_pushboolean(L, toggleModifier(1));
    return 1;
}

static int l_left_alt(lua_State *L) {
    lua_pushboolean(L, toggleModifier(2));
    return 1;
}

static int l_left_meta(lua_State *L) {
    lua_pushboolean(L, toggleModifier(3));
    return 1;
}

static int l_right_ctrl(lua_State *L) {
    lua_pushboolean(L, toggleModifier(4));
    return 1;
}

static int l_right_shift(lua_State *L) {
    lua_pushboolean(L, toggleModifier(5));
    return 1;
}

static int l_right_alt(lua_State *L) {
    lua_pushboolean(L, toggleModifier(6));
    return 1;
}

static int l_right_meta(lua_State *L) {
    lua_pushboolean(L, toggleModifier(7));
    return 1;
}

static int l_tap_left_meta(lua_State *L) {
    toggleModifier(3);
    toggleModifier(3);
    return 0;
}

void tapKey(hid_code) {
    pressKey(hid_code);
    sendHIDReport();
    releaseKey(hid_code);
    sendHIDReport();
}

static int l_tap_enter(lua_State *L) {
    tapKey(0x28);
    return 0;
}

static int l_tap_space(lua_State *L) {
    tapKey(0x27);
    return 0;
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
        if (code >= 49 && code <= 47){
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

static int l_press_key (lua_State *L) {
    unsigned short hid_code = luaL_checknumber(L, 1); // Get argument
    printf("l_press_key %02x\n", hid_code);
    if(!isPressed(hid_code)){
        pressKey(hid_code);
        lua_pushboolean(L, 1);
        printf("Key %d pushed\n", hid_code);
        sendHIDReport();
    }
    else
    {
        lua_pushboolean(L, 0);
    }
    return 1; // Return count of returned arguments
}

static int l_release_key (lua_State *L) {
    unsigned short hid_code = luaL_checknumber(L, 1); // Get argument
    printf("l_release_key %02x\n", hid_code);

    if(releaseKey(hid_code)){
        lua_pushboolean(L, 1);
        printf("Key %d released\n", hid_code);
        sendHIDReport();
    }
    else
    {
        lua_pushboolean(L, 0);
    }
    return 1; // Return count of returned arguments
}


int initLUA() {
    L = luaL_newstate();
    luaL_openlibs(L);

    lua_pushcfunction(L, l_press_key);
    lua_setglobal(L, "press_key");

    lua_pushcfunction(L, l_release_key);
    lua_setglobal(L, "release_key");

    lua_pushcfunction(L, l_set_key);
    lua_setglobal(L, "set_key");

    lua_pushcfunction(L, l_send_text);
    lua_setglobal(L, "text");

    lua_pushcfunction(L, l_sleep);
    lua_setglobal(L, "sleep");

    lua_pushcfunction(L, l_usleep);
    lua_setglobal(L, "usleep");

    lua_pushcfunction(L, l_left_ctrl);
    lua_setglobal(L, "left_ctrl");
    
    lua_pushcfunction(L, l_left_shift);
    lua_setglobal(L, "left_shift");

    lua_pushcfunction(L, l_left_alt);
    lua_setglobal(L, "left_alt");

    lua_pushcfunction(L, l_left_meta);
    lua_setglobal(L, "left_meta");


    lua_pushcfunction(L, l_tap_enter);
    lua_setglobal(L, "tap_enter");

    lua_pushcfunction(L, l_tap_space);
    lua_setglobal(L, "tap_space");

    lua_pushcfunction(L, l_tap_left_meta);
    lua_setglobal(L, "tap_left_meta");


    lua_pushcfunction(L, l_right_ctrl);
    lua_setglobal(L, "right_ctrl");
    
    lua_pushcfunction(L, l_right_shift);
    lua_setglobal(L, "right_shift");

    lua_pushcfunction(L, l_right_alt);
    lua_setglobal(L, "right_alt");

    lua_pushcfunction(L, l_right_meta);
    lua_setglobal(L, "right_meta");

  
    int status;
    status = luaL_loadfile(L, "/boot/keys.lua");
    if(status) {
        printf("Couldn't load keys.lua: %s\n", lua_tostring(L, -1));
        return 1;
    }
    status = lua_pcall(L, 0, LUA_MULTRET, 0);
    return 0;
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
