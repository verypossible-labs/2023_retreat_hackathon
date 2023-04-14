# Testing

## Mocks

Even though our host target environment is mostly useful within a development context, it can still be a good idea to have return data that would be in line with real world results. For example, our temperature sensor we can return random values between 0 and 30 degrees celsius or we could hardcode a single data point that matches the current environment. [See here](../../lib/retreat_hack/temp_hum_sensor/mock.ex) for examples.

## Unit tests

Mocks will also be useful for testing our code. We will use [the Mox library](https://hexdocs.pm/mox/Mox.html) to help facilitate testing with stubs and expectations. First you may need to install dependencies:

```sh
mix deps.get
```

Then follow the Mox documentation to ensure Mox is configure correctly for usage. This involves adding a mocks.exs file and updating the mix.exs file compilation paths for the testing environment. After configuration is complete we can add a new Mox mock based off of our `TempHumSensor` behaviour:

```elixir
Mox.defmock(RetreatHack.TempHumSensor.TestMock, for: RetreatHack.TempHumSensor)
```

Then we can add tests for simple `get_temperature/0` and `get_humidity/0` functions within our `RetreatHack` module. [See here](../../test/retreat_hack_test.exs) for examples.

## Extra Credit

Take the lessons applied during this step and apply them to an I2C mock that we can use to test the `AHT20.ex` module.

When you are satisfied with your tests, please return to [the README](../../README.md) and follow the instructions to proceed to step 4.
