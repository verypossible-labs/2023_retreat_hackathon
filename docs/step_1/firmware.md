# Build and run firmware

## Build firmware

```sh
mix firmware
```

## Burn firmware

Insert your Micro SD card into you USB hub so that your computer can recognize the card and run the burn command:

```sh
mix burn
```

You will need confirm that the firmware is being written to the correct disk and may need to provide administrator permissions.

## Run firmware

Remove the Micro SD card from the USB hub and insert it into the rpi0. Connect the rpi0 to power.

When you see and LED flashing on the rpi0 that means you device is booting/running and ready to connect to the console. Click [here](console.md) for the steps on how to connect to the console via serial.
