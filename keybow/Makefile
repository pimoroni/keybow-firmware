keybow: CFLAGS+=-static -I../lua-5.3.5/src -L/lib -L../lua-5.3.5/src -lpng -lz -llua -lm -lusbgx -lconfig -lbcm2835
keybow: keybow.c lights.c lua-config.c gadget-hid.c
	$(CC)  $^ $(CFLAGS) -o $@


luatest: CFLAGS+=-static -I../lua-5.3.5/src -L../lua-5.3.5/src -llua -lm
luatest: luatest.c
	$(CC) $^ $(CFLAGS) -o $@


lightstest: CFLAGS+=-L../bcm2835-1.57/src -lpng -lbcm2835
lightstest: lightstest.c lights.c
	$(CC) $^ $(CFLAGS) -o $@
