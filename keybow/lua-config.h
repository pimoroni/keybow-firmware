#include <errno.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#pragma once

int hid_output;
int midi_output;
int has_tick;
unsigned long long tick_start;
lua_State* L;

unsigned short last_media_keys;
unsigned short media_keys;
unsigned short modifiers;
unsigned short pressed_keys[14];

int initLUA();
void luaTick(void);
int luaHandleKey(unsigned short key_index, unsigned short state);
void luaClose(void);
void luaCallSetup(void);
