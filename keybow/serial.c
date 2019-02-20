#include <stdio.h>
#include <libserialport.h>
#include <stdlib.h>

//const char* serial_port = "/dev/ttyAMA0";
//const char* serial_port = "/dev/tnt0";
const char* serial_port = "/dev/ttyGS0";
struct sp_port *port;

int sp_readline(char *buffer, int length) {
    int index = 0;
    if (sp_input_waiting(port) > 0) {
        //printf("Processing input...\n");
        char c;
        while((sp_blocking_read(port, &c, 1, 100) > 0) && (index < length - 1)) {
            //printf("c: %c %d\n", c, (int)c);
            if (c == '\n') break;
            if (c != '\r') buffer[index++] = c;
        }
    }
    buffer[index] = '\0';
    //printf("b: %d %s\n", index, buffer);
    return index;
}

int serial_open(){
    int error = sp_get_port_by_name(serial_port, &port);
    if (error != SP_OK) {
        printf("Unable to find serial port: %s.\n", serial_port);
        return 1;
    }
    error = sp_open(port, SP_MODE_READ);
    if (error != SP_OK) {
        printf("Unable to open serial port for reading.\n");
        return 1;
    }
    sp_set_baudrate(port, 57600);
    //sp_close(port);
    return 0;
}

char* serial_read(){
    char *buffer = malloc(1024);
    int length = sp_readline(buffer, 1023);
    if (length > 0){
        return buffer;
    }
    /*int pending_bytes = sp_input_waiting(port);
    printf("Pending: %d\n", pending_bytes);
    char* buf;
    if (pending_bytes > 0) {
        buf = malloc(pending_bytes + 1);
        int ret = sp_blocking_read(port, buf, pending_bytes, 10);
        if(ret > 0){
            return buf;
        }
    }*/
    return (const char*)""; 
}

int serial_write(const char* data, int length){
    return sp_blocking_write(port, data, length, 10);
}
