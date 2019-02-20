#include "serial.h"
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <termios.h>
#include <unistd.h>

#define READLINE_BUFFER_LEN 512

char readline_buffer[READLINE_BUFFER_LEN];

int port_fd = -1;
struct termios termios;

int sp_readline() {
    int index = 0;
        char c;
        while(read(port_fd, &c, 1) == 1){
            if (c == '\n') break;
            if (c != '\r') readline_buffer[index++] = c;
        }
    readline_buffer[index++] = '\0';
    return index;
}

int serial_open(){
    if(port_fd > -1) return 0;

    port_fd = open(KEYBOW_SERIAL, O_RDWR);

    if(port_fd > -1){
        printf("Open success\n");
        tcgetattr(port_fd, &termios);
        termios.c_lflag &= ~ICANON;
        termios.c_cc[VTIME] = 10;
        termios.c_cc[VMIN] = 0;
        tcsetattr(port_fd, TCSANOW, &termios);
    }
    return 0;
}

char* serial_read(){
    serial_open();
    int length = sp_readline();
    return readline_buffer;
}

int serial_write(const char* data, int length){
    serial_open();
    return write(port_fd, data, length);
}
