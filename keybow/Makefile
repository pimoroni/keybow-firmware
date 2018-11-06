keybow: CFLAGS+=-static -I../lua-5.3.5/src -L../lua-5.3.5/src -llua -lm -lusbgx -lconfig -lbcm2835
keybow: keybow.c lua-config.c gadget-hid.c
	$(CC)  $^ $(CFLAGS) -o $@


luatest: CFLAGS+=-static -I../lua-5.3.5/src -L../lua-5.3.5/src -llua -lm
luatest: luatest.c
	$(CC) $^ $(CFLAGS) -o $@
