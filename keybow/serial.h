int sp_readline(char (*buffer)[], int length);
int serial_open();
const char* serial_read();
int serial_write(const char* data, int length);
