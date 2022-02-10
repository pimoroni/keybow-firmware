#include "lights.h"

int main(int argc, char **argv) {
        initLights();

        read_png_file(argv[1]);

        while (1) {
            int delta = (millis() / (1000/60)) % lights_getHeight();
            printf("Frame: %d\n", delta);
            lights_drawPngFrame(delta);
            lights_show();
            usleep(1000000/60);
        }
}
