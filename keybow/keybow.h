#include <bcm2835.h>
#include <pthread.h>
#include "lights.h"
#include "lua-config.h"

#define NUM_KEYS 12

#ifndef KEYBOW_HOME
#define KEYBOW_HOME "/boot/"
#endif

typedef struct keybow_key {
    unsigned short gpio_bcm;
    unsigned short hid_code;
    unsigned short led_index;
} keybow_key;

keybow_key get_key(unsigned short index);
int initUSB();
int initGPIO();
int main();
