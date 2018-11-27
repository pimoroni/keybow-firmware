#include "lights.h"

unsigned long long millis(){
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (unsigned long long)(tv.tv_sec) * 1000 + (unsigned long long)(tv.tv_usec) / 1000;
}

void abort_(const char * s, ...)
{
    va_list args;
    va_start(args, s);
    vfprintf(stderr, s, args);
    fprintf(stderr, "\n");
    va_end(args);
    // abort();
}

int read_png_file(char* file_name)
{
    char header[8];    // 8 is the maximum size that can be checked

    /* open file and test for it being a png */
    FILE *fp = fopen(file_name, "rb");
    if (!fp) {
        abort_("[read_png_file] File %s could not be opened for reading", file_name);
        return 1;
    }
    fread(header, 1, 8, fp);
    if (png_sig_cmp(header, 0, 8)) {
        abort_("[read_png_file] File %s is not recognized as a PNG file", file_name);
        return 1;
    }

    /* initialize stuff */
    png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

    if (!png_ptr) {
        abort_("[read_png_file] png_create_read_struct failed");
        return 1;
    }

    info_ptr = png_create_info_struct(png_ptr);
    if (!info_ptr) {
        abort_("[read_png_file] png_create_info_struct failed");
        return 1;
    }

    if (setjmp(png_jmpbuf(png_ptr))) {
        abort_("[read_png_file] Error during init_io");
        return 1;
    }

    png_init_io(png_ptr, fp);
    png_set_sig_bytes(png_ptr, 8);

    png_read_info(png_ptr, info_ptr);

    width = png_get_image_width(png_ptr, info_ptr);
    height = png_get_image_height(png_ptr, info_ptr);
    color_type = png_get_color_type(png_ptr, info_ptr);
    bit_depth = png_get_bit_depth(png_ptr, info_ptr);
    color_channels = png_get_channels(png_ptr, info_ptr);

    number_of_passes = png_set_interlace_handling(png_ptr);
    png_read_update_info(png_ptr, info_ptr);


    /* read file */
    if (setjmp(png_jmpbuf(png_ptr))) {
        abort_("[read_png_file] Error during read_image");
        return 1;
    }

    row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * height);
    for (y=0; y<height; y++)
        row_pointers[y] = (png_byte*) malloc(png_get_rowbytes(png_ptr,info_ptr));

    png_read_image(png_ptr, row_pointers);

    fclose(fp);

    return 0;
}

int initLights() {
    bcm2835_init();
    bcm2835_spi_begin();
    bcm2835_spi_set_speed_hz(SPI_SPEED_HZ);
    bcm2835_spi_setDataMode(BCM2835_SPI_MODE0);
    bcm2835_spi_chipSelect(BCM2835_SPI_CS0);
    bcm2835_spi_setChipSelectPolarity(BCM2835_SPI_CS0, LOW);

    int x;
    for(x = 0; x < BUF_SIZE; x++){
        buf[x] = 0;
    }

    for(x = BUF_SIZE - SOF_BYTES; x < BUF_SIZE; x++){
        buf[x] = 255;
    }
}

void lights_setPixel(int x, int r, int g, int b){
    int offset = SOF_BYTES + (x * 4);
    buf[offset + 0] = 0b11100011;
    buf[offset + 1] = b;
    buf[offset + 2] = g;
    buf[offset + 3] = r;
}

void lights_setAll(int r, int g, int b){
    int x;
    for(x = 0; x < 12; x++){
        lights_setPixel(x, r, g, b);
    }
}

void lights_show(){
    int x;
    bcm2835_spi_writenb(buf, BUF_SIZE);
    usleep(MIN_DELAY_US);
}

void lights_cleanup(){
    bcm2835_spi_end();
    bcm2835_close();
}

void lights_drawPngFrame(int frame){
    if(width == 4){
    /*
        4x3xN animation image,
        each 4x3 area represents a single frame.
    */
    frame = (frame % (height / 3)) * 3;
    for(y = 0; y < 3; y++){
        png_byte* row = row_pointers[frame + y];
        for(x = 0; x < 4; x++){
        png_byte* ptr = &(row[x * color_channels]);
        lights_setPixel(x + (y * 4), ptr[0], ptr[1], ptr[2]);
        // printf("x: %d, y: %d, xy: %d  ", x, y, x + (y*4));
        // printf("r: %d, g: %d, b: %d\n", ptr[0], ptr[1], ptr[2]);
        }
    }
    return;
    }
    /* 
    Other - will try to fit horizontal pixels to keys,
    wrapping where necessary.
    each vertical pixel is one frame
    */
    frame = frame % height;
    png_byte* row = row_pointers[frame];
    for(x = 0; x < 12; x++){
        int offset = (x % width) * color_channels;
        png_byte* ptr = &(row[offset]);
        lights_setPixel(x, ptr[0], ptr[1], ptr[2]);
    }
    return;
}
