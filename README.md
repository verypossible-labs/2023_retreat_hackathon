# 2023 Retreat Hackathon

## Getting Started

Welcome to the 2023 retreat hackathon. The goal of this project is to get you (a web or mobile based software engineer) familiar with some common tools of IoT development primarily from the perspective of hardware and firmware. To that end, we will be covering:

- First time Nerves setup and basic Nerves/Elixir programming patterns
- Basic wiring and development tools for firmware
- Interacting with the serial console (UART, debugging)
- Using pinout diagrams
- Lower level protocol usage (I2C)
- Using datasheets
- Cloud connectivity best practices (Wifi setup, AWS IoT Core)
- Basic cloud communication (Mqtt)

## Recommended Tooling

### Software

- [asdf](https://github.com/asdf-vm/asdf) - Version manager
- [direnv](https://direnv.net/) - Environment manager
- [picocom](https://linux.die.net/man/8/picocom) - terminal emulator

### Hardware

- Raspberry Pi Zero (rpi0)
- USB hub with support for USB type A and Micro SD card. (All future instructions will assume you are interacting with the USB hub)
- Micro SD card
- USB to Serial debug cable
- [AHT20 temperature and humidity sensor](https://www.adafruit.com/product/4566)
- [Qwiic JST SH wire with female sockets](https://www.adafruit.com/product/4397)

### Optional

- Breadboard
- Assorted breadboard wires
- LEDs
- Assorted resistors

## [Step 1 Setup Nerves](docs/step_1.md)

## [Step 2 Read from the sensor](docs/step_2.md)

## [Step 3 Code organization and development best practices](docs/step_3.md)

When you are ready for Step 4 please:

```sh
git checkout step_4
```
