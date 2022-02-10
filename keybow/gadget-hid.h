#include <linux/usb/ch9.h>
#include <usbg/usbg.h>
#include <usbg/function/hid.h>

#define VENDOR          0x1d6b
#define PRODUCT         0x0104
#define HID_REPORT_SIZE 16
#define MOUSE_REPORT_SIZE 3

void sendMIDINote(int channel, int note, int velocity, int state);

void setMouseXY(signed short x, signed short y);
void setMouseButton(unsigned short button, unsigned short state);

int isPressed(unsigned short hid_code);
int releaseKey(unsigned short hid_code);
void pressKey(unsigned short hid_code);

int toggleModifier(unsigned short modifier);
unsigned short getModifier(unsigned short index);
unsigned short setModifier(unsigned short index, unsigned short state);

int toggleMediaKey(unsigned short modifier);
unsigned short getMediaKey(unsigned short index);
unsigned short setMediaKey(unsigned short index, unsigned short state);

void sendHIDReport();
void sendMouseReport();

int initUSB();
int initHID();
int cleanupUSB();
