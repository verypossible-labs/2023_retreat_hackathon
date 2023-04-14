# Running code on host computer

## Why run on host?

It is common to want to be able to run the majority of the application logic or business logic outside of the context of the embedded hardware. This is useful for local development or integration between firmware and cloud software. Nerves supports this feature by use of the `:host` `MIX_TARGET`. The `:host` target will be the default target unless otherwise specified. You can run your application for the host by simply executing the IEx repl in the context of our application:

```sh
iex -S mix
```

Just by starting the console, you've likely seen some compilation warnings about the availability of the `Circuits.I2C` module. This makes sense because when we check the dependencies in our `mix.exs` file we see that the `:circuits_i2c` library targets only the rpi0. Within the console, it is possible to run the same commands as we ran previously on the rpi0. Try one now. You should receive an error message about how `(module Circuits.I2C is not available)`.

## Bypass hardware requirements

Since most laptop computers do not support I2C communication without some type of breakout board, we cannot expect our hardware protocol code to operate in the host environment. So instead we will stub out our hardware code. In Elixir we can us a combination of configuration and [behaviours](https://elixir-lang.org/getting-started/typespecs-and-behaviours.html#behaviours) to achieve the results we want. First we can write our behaviour which will define the functions we expect our Temperature/Humidity sensor to have and then we can configure our application to use different modules for different mix targets.

```elixir
defmodule RetreatHack.TempHumSensor do
  @callback start_link(keyword()) :: GenServer.on_start()
  @callback get_humidity(identifier()) :: float()
  @callback get_temperature(identifier()) :: float()
end

defmodule RetreatHack.TempHumSensor.AHT20 do
  @behaviour RetreatHack.TempHumSensor
end
```

Please try to implement these yourself. [See](../../lib/retreat_hack.ex) [here](../../config/host.exs) [for](../../lib/retreat_hack/temp_hum_sensor.ex) [examples](../../lib/retreat_hack/temp_hum_sensor/AHT20.ex).

Afterwards you should be able to run code on your host and while it won't return accurate temperature or humidity results based on sensor reading there are other interesting things we can do with this code as we'll see in [the next section](mock.md). In addition, we should still be able to burn a new firmware image and our sensor should continue to provide readings for firmware targeting the rpi0.

## Questions for thought

- How might we do similar dependency injection in C or some other language?
- What other benefits can we achieve by using the above form of dependency injection?
- Would it make sense to define a behaviour for the I2C connectivity code? Why or why not?

[next](mock.md)
