#include "gadget-hid.h"
#include <errno.h>
#include <stdio.h>
#include <linux/usb/ch9.h>
#include <usbg/usbg.h>
#include <usbg/function/hid.h>

static char report_desc[] = {
    0x05, 0x01, // USAGE_PAGE (Generic Desktop)
    0x09, 0x06, // USAGE (Keyboard)
    0xA1, 0x01, // COLLECTION (Application)

    //             Bitmapped Modifiers

    0x05, 0x07, // USAGE_PAGE (Key Codes)
    0x19, 0xE0, // USAGE_MINIMUM (224)
    0x29, 0xE7, // USAGE_MAXIMUM (231)
    0x15, 0x00, // LOGICAL_MINIMUM (0)
    0x25, 0x01, // LOGICAL_MAXIMUM (1)
    0x75, 0x01, // REPORT_SIZE (1)
    0x95, 0x08, // REPORT_COUNT (8)
    0x81, 0x02, // INPUT (Data, Variable, Absolute)

    //             Reserved

    0x95, 0x01, // REPORT_COUNT (1)
    0x75, 0x08, // REPORT_SIZE (8)
    0x81, 0x01, // INPUT (Constant)

    //             LEDs

    0x05, 0x08, // USAGE_PAGE (LED)
    0x19, 0x01, // USAGE_MINIMUM (1)
    0x29, 0x05, // USAGE_MAXIMUM (5)
    0x95, 0x05, // REPORT_COUNT (5)
    0x75, 0x01, // REPORT_SIZE (1)
    0x91, 0x02, // OUTPUT (Data, Variable, Absolute)

    //             Padding

    0x95, 0x01, // REPORT_COUNT (1)
    0x75, 0x03, // REPORT_SIZE (3)
    0x91, 0x03, // OUTPUT (Constant)

    //             Keyboard Keys

    0x15, 0x00, // LOGICAL_MINIMUM (0)
    0x25, 0xFF, // LOGICAL_MAXIMUM (255)
    0x05, 0x07, // USAGE_PAGE (Key Codes)
    0x19, 0x00, // USAGE_MINIMUM (0)
    0x29, 0xFF, // USAGE_MAXIMUM (255)
    0x95, HID_REPORT_SIZE - 2, // REPORT_COUNT (14)
    0x75, 0x08, // REPORT_SIZE (8)
    0x81, 0x00, // OUTPUT (Data, Array, Abolute)

    0xC0        // END_COLLECTION
};

int initUSB() {
	int ret = -EINVAL;
	int usbg_ret;

	struct usbg_gadget_attrs g_attrs = {
		.bcdUSB = 0x0200,
		.bDeviceClass =	USB_CLASS_PER_INTERFACE,
		.bDeviceSubClass = 0x00,
		.bDeviceProtocol = 0x00,
		.bMaxPacketSize0 = 64, /* Max allowed ep0 packet size */
		.idVendor = VENDOR,
		.idProduct = PRODUCT,
		.bcdDevice = 0x0001, /* Verson of device */
	};

	struct usbg_gadget_strs g_strs = {
		.serial = "0123456789", /* Serial number */
		.manufacturer = "Foo Inc.", /* Manufacturer */
		.product = "Bar Gadget" /* Product string */
	};

	struct usbg_config_strs c_strs = {
		.configuration = "1xHID"
	};

	struct usbg_f_hid_attrs f_attrs = {
		.protocol = 1,
		.report_desc = {
			.desc = report_desc,
			.len = sizeof(report_desc),
		},
		.report_length = HID_REPORT_SIZE,
		.subclass = 0,
	};

	usbg_ret = usbg_init("/sys/kernel/config", &s);
	if (usbg_ret != USBG_SUCCESS) {
		fprintf(stderr, "Error on usbg init\n");
		fprintf(stderr, "Error: %s : %s\n", usbg_error_name(usbg_ret),
				usbg_strerror(usbg_ret));
		goto out1;
	}

	usbg_ret = usbg_create_gadget(s, "g1", &g_attrs, &g_strs, &g);
	if (usbg_ret != USBG_SUCCESS) {
		fprintf(stderr, "Error creating gadget\n");
		fprintf(stderr, "Error: %s : %s\n", usbg_error_name(usbg_ret),
				usbg_strerror(usbg_ret));
		goto out2;
	}
	usbg_ret = usbg_create_function(g, USBG_F_HID, "usb0", &f_attrs, &f_hid);
	if (usbg_ret != USBG_SUCCESS) {
		fprintf(stderr, "Error creating function\n");
		fprintf(stderr, "Error: %s : %s\n", usbg_error_name(usbg_ret),
				usbg_strerror(usbg_ret));
		goto out2;
	}

	usbg_ret = usbg_create_config(g, 1, "The only one", NULL, &c_strs, &c);
	if (usbg_ret != USBG_SUCCESS) {
		fprintf(stderr, "Error creating config\n");
		fprintf(stderr, "Error: %s : %s\n", usbg_error_name(usbg_ret),
				usbg_strerror(usbg_ret));
		goto out2;
	}

	usbg_ret = usbg_add_config_function(c, "some_name", f_hid);
	if (usbg_ret != USBG_SUCCESS) {
		fprintf(stderr, "Error adding function\n");
		fprintf(stderr, "Error: %s : %s\n", usbg_error_name(usbg_ret),
				usbg_strerror(usbg_ret));
		goto out2;
	}

	usbg_ret = usbg_enable_gadget(g, DEFAULT_UDC);
	if (usbg_ret != USBG_SUCCESS) {
		fprintf(stderr, "Error enabling gadget\n");
		fprintf(stderr, "Error: %s : %s\n", usbg_error_name(usbg_ret),
				usbg_strerror(usbg_ret));
		goto out2;
	}

	ret = 0;

out2:
	usbg_cleanup(s);

out1:
	return ret;
}

int cleanupUSB(){
    usbg_cleanup(s);
    return 0;
}
