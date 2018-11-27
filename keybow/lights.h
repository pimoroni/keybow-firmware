#pragma once

#include <bcm2835.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <sys/time.h>
#include <pthread.h>

#define PNG_DEBUG 3
#include <png.h>

#define NUM_PIXELS 12
#define SOF_BYTES 4
#define EOF_BYTES 4
#define BUF_SIZE ((NUM_PIXELS * 4) + SOF_BYTES + EOF_BYTES)

#define SPI_SPEED_HZ 4000000
#define MIN_DELAY_US 500

char buf[BUF_SIZE];

int x, y;

int width, height;
png_byte color_type;
png_byte bit_depth;
png_byte color_channels;

png_structp png_ptr;
png_infop info_ptr;
int number_of_passes;
png_bytep * row_pointers;

unsigned long long millis();
void lights_setPixel(int x, int r, int g, int b);
void lights_setAll(int r, int g, int b);
void lights_show();
void lights_cleanup();
void lights_drawPngFrame(int frame);
int read_png_file(char* file_name);
