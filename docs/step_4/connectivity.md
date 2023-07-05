# Connectivity

## Technologies

It is important to decide how your device will access the Internet. There are many options that will all require different hardware, firmware, configuration and design patterns for device setup and management. Some options include:

- WiFi
- Cellular
- Ethernet

In addition an IoT system may have one Internet connection per device or a pattern of node devices connecting to a gateway over Bluetooth or LoRaWAN or Thread or one of many other short range wireless communication technologies while the gateway will manage the Internet level communication.

For our purposes on this project, the rpi0, and associated Nerves System, come with the necessary hardware and software for a direct WiFi connection which we will expore here.

## Depenedencies

Nerves primarly uses [VintageNet](https://github.com/nerves-networking/vintage_net) to manage network configuration. We will be using [the WiFi plugin](https://github.com/nerves-networking/vintage_net_wifi) and to make things extra easy, we can use [the WiFi setup Wizard](https://github.com/nerves-networking/vintage_net_wizard) plugin to avoid configuring more environment variables or hardcoding network credentials.

Our dependencies list should include the following:

```elixir
{:vintage_net_wifi, "~> 0.11.0"},
{:vintage_net_wizard, "~> 0.4"},
```

Ensure dependencies have been installed and are up to date.

We will also need to [configure](../../config/host.exs) (lines 7 - 13) these libraries so that our code will continue to run in the host environment (where we do not need to manage network configuration). This involves configuring VintageNet to look to `/dev/null` for some file interactions and providing a mock for the wizard. After this configuration is setup, you should be able to start the app on host and have it operate as normal.

## Internet on Hardware

It is time to build our firmware to try and run it on the rpi0. Make sure your Micro SD card is ready to write and burn the image.

```sh
MIX_ENV=rpi0 mix firmware.burn
```

Then we'll insert the card back into the rpi0 and reboot. When Nerves comes back up we should be able to interact with the console. To run our wizard we can simply call it:

```elixir
VintageNetWizard.run_wizard()
```

This should create a new WiFi AP with the name `nerves-(some random board ID here)`. Connect to the AP on your mobile phone or other WiFi enabled device and the captive portal functionality should engage quickly. After entering network credentials and saving the configuration, AP should drop, returning your device to its previous WiFi network and connecting the rpi0 to the configured network. You can test this by using `ping`:

```elixir
ping "verytechnology.com"
```

Now you should try to connect to AWS via MQTT and try publishing messages.

## Configuration

In some cases it is not possible to configure WiFi via a wizard or it may just be easier for local development to use an alternate network configuration that won't be used in production. Take some time to review the configuration options available. Consider how you might configure multiple network technologies or make use of your local WiFi without needing a configuration process.

## OTA Updates

Now that we're running our firmware and connected to the Internet, we no longer need to bother with slow and messy Micro SD card flashing. We can use OTA updates to deliver new firmware to our device. The whole process is complex and will take more time than is availabe in these documents but please review the [Peridio documentation](https://docs.peridio.com/reference) and [open source code](https://github.com/peridio/peridiod) or visit the #peridio-very-feedback-support slack channel.

Extra: Request a development account from Peridio and follow the guides to publish OTA updates for your firmware.

## Code Improvements

Now that we are successfully connected to the Internet, we can configure our firmware to do more than respond to commands we write in the console. Some exercises that will be useful for further firmware development.

- Configure the firmware to automatically start the WiFi wizard if Wifi has not been configured.
- Configure the firmware to automatically connect to AWS via MQTT when Internet connectivity has been established.
- Write a module that will read data from the sensor and transmit that data to the cloud once per minute.
- In the MQTT module [a handler](../../lib/retreat_hack/cloud_comm/mqtt.ex) is provided on line 48. This is the default echo handler that simply echoes back messages that it receives. Review the [Tortoise311 Handler behaviour](https://hexdocs.pm/tortoise311/0.10.4/Tortoise.Handler.html) in order to understand the requirements. Now create your own handler that can respond to MQTT events and perform a commands such as reporting the sensor readings on demand.

After completing the above, you will have completed the basics of an IoT project. Congratulations!

## Conclusion

Over the course of this project we have covered many of the tools and practices necessary for working with embedded software. Of course many other skills and tools will be needed on the many projects that we support here at Very. You may have identified some of the gaps in this guide or may have ideas for how you might want to develop your personal IoT project further. Please use this tool as a starting off point and work with your manager or director to figure out ways to use these tools to further develop your skills. I hope you had fun and good luck.
