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


    lua_pushcfunction(L, l_left_ctrl);
    lua_setglobal(L, "left_ctrl");
    
    lua_pushcfunction(L, l_left_shift);
    lua_setglobal(L, "left_shift");

    lua_pushcfunction(L, l_left_alt);
    lua_setglobal(L, "left_alt");

    lua_pushcfunction(L, l_left_meta);
    lua_setglobal(L, "left_meta");

    int status;
    status = luaL_loadfile(L, "keys.lua");
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
        printf("Calling: %s\n", fn);
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
    lua_close(L);
}
