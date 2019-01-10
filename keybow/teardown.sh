GADGET=g1
CONFIGFS=/sys/kernel/config/usb_gadget
GADGETDIR=$CONFIGFS/$GADGET

echo "" > $GADGETDIR/UDC
rmdir $GADGETDIR/configs/*/strings/*
rm -f $GADGETDIR/configs/*/keyboard
rmdir $GADGETDIR/configs/*
rmdir $GADGETDIR/functions/*
rmdir $GADGETDIR/strings/*
rmdir $GADGETDIR
