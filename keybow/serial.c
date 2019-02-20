#include "serial.h"
#include <stdio.h>
#include <libserialport.h>
#include <stdlib.h>

#define READLINE_BUFFER_LEN 512

//const char* serial_port = "/dev/ttyAMA0";
//const char* serial_port = "/dev/tnt0";
//const char* serial_port = "/dev/ttyGS0";
struct sp_port *port;

char readline_buffer[READLINE_BUFFER_LEN];

int port_open = 0;

int sp_readline() {
    int index = 0;
    if (sp_input_waiting(port) > 0) {
        //printf("Processing input...\n");
        char c;
        while((sp_blocking_read(port, &c, 1, 100) > 0) && (index < READLINE_BUFFER_LEN - 1)) {
            //printf("c: %c %d\n", c, (int)c);
            if (c == '\n') break;
            if (c != '\r') readline_buffer[index++] = c;
        }
    }
    readline_buffer[index++] = '\0';
    //printf("b: %d %s\n", index, buffer);
    return index;
}

int serial_open(){
    char *emsg;
    if(port_open){
        return 0;
    }
    printf("opening port...\n");
    int error = sp_get_port_by_name(KEYBOW_SERIAL, &port);
    if (error != SP_OK) {
        printf("Unable to find serial port: %s.\n", KEYBOW_SERIAL);
        return 1;
    }
    error = sp_open(port, SP_MODE_READ);
    if (error != SP_OK) {
        printf("Unable to open serial port for reading.\n");
        emsg = sp_last_error_message();
        printf("%s\n", emsg);
        sp_free_error_message(emsg);
        return 1;
    }
    sp_set_baudrate(port, 57600);
    port_open = 1;
    //sp_close(port);
    return 0;
}

char* serial_read(){
    serial_open();
    //static char *buffer[1024] = {0}; // = malloc(1024);
    int length = sp_readline();
    return readline_buffer;
    //if (length > 0){
        //return buffer;
    //}
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
    //return buffer;
}

int serial_write(const char* data, int length){
    serial_open();
    return sp_blocking_write(port, data, length, 10);
}
