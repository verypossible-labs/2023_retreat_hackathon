# Console access

- Connect your USB -> Serial cable to the USB hub.
- Using [the pinout](https://pinout.xyz/pinout/uart) of the rpi0 determine how to connect the cable to the rpi0.
- It is possible you will need to install [FTDI drivers](https://ftdichip.com/drivers/vcp-drivers/) in order to interface with the serial port.
- It is possible to configure [`erlinit`](https://github.com/nerves-project/erlinit) to force a specific controlling terminal if necessary:

```elixir
# target.exs

config :nerves, :erlinit,
  ctty: "ttyAMA0"
```

- Use some terminal emulator to connect to the serial port:

```sh
picocom -b 115200 /dev/tty.YOUR-PORT
```

- When successful, you should see the elixir shell command prompt `iex(1)>`. Try several commands to familiarize yourself with operation of the terminal emulator as well as the Elixir console.

After successfully interacting with the console please return to the [README](../../README.md) and follow the instructions to step 2.
