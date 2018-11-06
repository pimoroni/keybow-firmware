#include "keybow.h"
#include "gadget-hid.h"
#include <signal.h>
#include <errno.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdio.h>
#include <bcm2835.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int hid_output;
int running = 0;

void signal_handler(int dummy) {
    running = 0;
}

keybow_key get_key(unsigned short index){
    keybow_key key;
    index *= 3;
    key.gpio_bcm = mapping_table[index + 0];
    key.hid_code = mapping_table[index + 1];
    key.led_index = mapping_table[index + 2];
    return key;
}

int initGPIO() {
    if (!bcm2835_init()){
        return 1;
    }
    int x = 0;
    for(x = 0; x < NUM_KEYS; x++){
        keybow_key key = get_key(x);
        bcm2835_gpio_fsel(key.gpio_bcm, BCM2835_GPIO_FSEL_INPT);
        bcm2835_gpio_set_pud(key.gpio_bcm, BCM2835_GPIO_PUD_UP);
    }
    return 0;
}

int updateKeys() {
    int x = 0;
    //unsigned short buf[HID_REPORT_SIZE];
    //for(x = 0; x < HID_REPORT_SIZE; x++){
    //    buf[x] = 0;
    //}
    //int buf_index = 2; // Skip modifier and padding bytes
    for(x = 0; x < NUM_KEYS; x++){
        keybow_key key = get_key(x);
        int state = bcm2835_gpio_lev(key.gpio_bcm) == 0;
        if(state != last_state[x]){
            luaHandleKey(x, state);            
        }
        last_state[x] = state;
        //if(state){
        //    buf[buf_index] = key.hid_code;
        //    buf_index++;
        //}
    }
    /*for(x = 0; x < HID_REPORT_SIZE; x++){
        printf("0x%02x ", buf[x]);
    }
    printf("\n");*/
    //write(hid_output, buf, HID_REPORT_SIZE);
}

int main() {
    int ret;

    if (initGPIO() != 0) {
        return 1;
    }

    ret = initUSB();
    //if (ret != 0 && ret != USBG_ERROR_EXIST) {
    //    return 1;
    //}

    do {
        hid_output = open("/dev/hidg0", O_WRONLY | O_NDELAY);
    } while (hid_output == -1 && errno == EINTR);
    if (hid_output == -1){
        printf("Error opening /dev/hidg0 for writing.\n");
        return 1;
    }

    ret = initLUA();
    if (ret != 0){
        return ret;
    }

    int x = 0;
    for(x = 0; x < NUM_KEYS; x++){
        last_state[x] = 0;
    }

    printf("Running...\n");
    running = 1;
    signal(SIGINT, signal_handler);
    while (running){
        updateKeys();
        usleep(1000);
        //usleep(250000);
    }      

    //cleanupUSB();
    bcm2835_close();
    luaClose();
    return 0;
}
