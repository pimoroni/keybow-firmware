#include <errno.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#pragma once

int hid_output;
lua_State* L;

unsigned short modifiers;
unsigned short pressed_keys[14];

static int l_press_key (lua_State *L);
static int l_release_key (lua_State *L);
int initLUA();
int luaHandleKey(unsigned short key_index, unsigned short state);
void luaClose(void);
void luaCallSetup(void);
