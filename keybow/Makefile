CFLAGS_ALL=-I../libusbgx/build/include -I../bcm2835-1.58/build/include -L../bcm2835-1.58/build/lib -I../lua-5.3.5/src -L../libusbgx/build/lib -L../libserialport/build/lib -L../lua-5.3.5/src -lpng -lz -lpthread -llua -lm -lbcm2835 -ldl

keybow: CFLAGS+=-static $(CFLAGS_ALL) -lusbgx -lconfig
keybow: keybow.c lights.c lua-config.c gadget-hid.c serial.c
	$(CC)  $^ $(CFLAGS) -o $@


luatest: CFLAGS+=-static -I../lua-5.3.5/src -L../lua-5.3.5/src -llua -lm -ldl
luatest: luatest.c
	$(CC) $^ $(CFLAGS) -o $@


lightstest: CFLAGS+=-L../bcm2835-1.58/src -lpng -lbcm2835 -lserialport
lightstest: lightstest.c lights.c
	$(CC) $^ $(CFLAGS) -o $@


keybow-test: CFLAGS+=-static -Wall -DKEYBOW_DEBUG -DKEYBOW_NO_USB_HID -DKEYBOW_HOME='"../sdcard"' -DKEYBOW_SERIAL='"/dev/tnt0"' $(CFLAGS_ALL)
keybow-test: keybow.c lights.c lua-config.c serial.c
	$(CC) $^ $(CFLAGS) -o $@

keybow-usbtest: CFLAGS+=-static -Wall -DKEYBOW_DEBUG -DKEYBOW_HOME='"../sdcard"' $(CFLAGS_ALL) -lusbgx -lconfig
keybow-usbtest: keybow.c lights.c lua-config.c gadget-hid.c serial.c
	$(CC) $^ $(CFLAGS) -o $@

clean:
	-rm keybow-test
	-rm keybow-usbtest
	-rm keybow
	-rm luatest
	-rm lightstest
