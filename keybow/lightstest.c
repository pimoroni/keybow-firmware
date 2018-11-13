#include "lights.h"

int main() {
        initLights();

        read_png_file("test.png");
        printf("W: %d H: %d\n",width,height);

        while (1) {
            int delta = (millis() / (1000/60)) % height;
            printf("Frame: %d\n", delta);
            lights_drawPngFrame(delta);
            lights_show();
            usleep(1000000/60);
        }
}
