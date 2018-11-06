#include <errno.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

lua_State* L;

static int l_press_key (lua_State *L) {
    unsigned short hid_code = lua_tonumber(L, 1); // Get argument
    lua_pushnumber(L, 1); // Return 1
    printf("Key %d pushed\n", hid_code);
    return 1; // Return count of returned arguments
}

static int l_release_key (lua_State *L) {
    unsigned short hid_code = lua_tonumber(L, 1); // Get argument
    lua_pushnumber(L, 1); // Return 1
    printf("Key %d released\n", hid_code);
    return 1; // Return count of returned arguments
}


int initLUA() {
    L = luaL_newstate();
    luaL_openlibs(L);

    lua_pushcfunction(L, l_press_key);
    lua_setglobal(L, "press_key");

    lua_pushcfunction(L, l_release_key);
    lua_setglobal(L, "release_key");

    int status;
    status = luaL_loadfile(L, "keys.lua");
    if(status) {
        printf("Couldn't load keys.lua: %s\n", lua_tostring(L, -1));
        return 1;
    }
    status = lua_pcall(L, 0, LUA_MULTRET, 0);
    return 0;
}

int luaHandleKey(unsigned short key_index) {
        char fn[14];
        sprintf(fn, "handle_key_%02d\0", key_index);
        printf("Calling: %s\n", fn);
        lua_getglobal(L, fn);
        if(lua_isfunction(L, lua_gettop(L))){
        lua_pushnumber(L, 0); // Index
        lua_pushnumber(L, 69); // State
        if (lua_pcall(L, 2, 1, 0) != 0){
            error(L, "error running function `handle_key`: %s", lua_tostring(L, -1));
        }
        if (!lua_isnumber(L, -1)){
            error(L, "function `handle_key` must return a number");
        }
        int result = lua_tonumber(L, -1);
        lua_pop(L, 1);
        printf("Result: %d\n", result);
        } else {
            printf("handle_key_%02d is not defined!\n");
            return 1;
        }

}

int main() {
    int ret;

    ret = initLUA();
    if (ret != 0){
        return ret;
    }

    printf("Running...\n");
    while (1){
        int x;
        for(x = 0; x < 5; x++){
            luaHandleKey(x);
        }
        usleep(500000);
    }      

    lua_close(L);
    return 0;
}
