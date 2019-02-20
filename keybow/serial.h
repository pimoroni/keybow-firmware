#ifndef KEYBOW_SERIAL
#define KEYBOW_SERIAL "/dev/ttyGS0"
#endif
int sp_readline();
int serial_open();
char* serial_read();
int serial_write(const char* data, int length);
