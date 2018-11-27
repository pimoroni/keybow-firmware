#include "lights.h"

int main(int argc, char **argv) {
        initLights();

        read_png_file(argv[1]);
        printf("W: %d H: %d D: %d T: %d C: %d\n",width,height,bit_depth,color_type,color_channels);

        while (1) {
            int delta = (millis() / (1000/60)) % height;
            printf("Frame: %d\n", delta);
            lights_drawPngFrame(delta);
            lights_show();
            usleep(1000000/60);
        }
}
