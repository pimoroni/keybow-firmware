#include <bcm2835.h>

#define NUM_KEYS 12

unsigned short last_state[NUM_KEYS];

typedef struct keybow_key {
    unsigned short gpio_bcm;
    unsigned short hid_code;
    unsigned short led_index;
} keybow_key;

const unsigned short mapping_table[36] = {
    RPI_V2_GPIO_P1_11, 0x27, 3,
    RPI_V2_GPIO_P1_13, 0x37, 7,
    RPI_V2_GPIO_P1_16, 0x28, 11,
    RPI_V2_GPIO_P1_15, 0x1e, 2,
    RPI_V2_GPIO_P1_18, 0x1f, 6,
    RPI_V2_GPIO_P1_29, 0x20, 10,
    RPI_V2_GPIO_P1_31, 0x21, 1,
    RPI_V2_GPIO_P1_32, 0x22, 5,
    RPI_V2_GPIO_P1_33, 0x23, 9,
    RPI_V2_GPIO_P1_38, 0x24, 0,
    RPI_V2_GPIO_P1_36, 0x25, 4,
    RPI_V2_GPIO_P1_37, 0x26, 8
};

int initUSB();
int initGPIO();
int main();
