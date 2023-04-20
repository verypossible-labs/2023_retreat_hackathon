# Reading a datasheet

Like most chips, the AHT20 sensor has [a datasheet](https://files.seeedstudio.com/wiki/Grove-AHT20_I2C_Industrial_Grade_Temperature_and_Humidity_Sensor/AHT20-datasheet-2020-4-16.pdf) that outlines the many technical details of the chip including instructions on how to interface with chip.

Take your time and look through the datasheet to note any areas of interest. For the purposes of this project though, you can skip ahead to page 8. Of particular note are the commands that will be needed to initialze the device and trigger a measurement. Some questions that will be worthwhile to ask:

- Are there any necessary command parameters?
- How will I be able to determine when measurements are complete and data will be available to read?
- Are there any clues you can use to determine the endianness of the bytes you will be reading?
- How many bytes will need to be read to get full measurements?
- How many bits represent the humidity reading?
- How many bits represent the temperature reading?
- Is there a formula for converting the readings into recognizable units of measurement for temperature and humidity?

In order to be efficient with your time, please note that you can safely ignore many of the extraneous features that might be desireable in a production device such as CRC checks, calibration, and implementing delays exactly according to the spec. For our purposes, simply initializing the device, sending the command to trigger a measurement, validating that the bytes we are reading are a completed measurement and reading the response should be sufficient. If you are looking for an extra challenge then implementing some of the extraneous features could be a good option.

After gather the necessary information from the datasheet, you are ready to [implement what you have learned in code](code.md#reading-data).
