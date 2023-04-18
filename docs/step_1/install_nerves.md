# Setup Elixir/Nerves

## Common Commands Reference

A full list can be discovered by running `mix help`.

- `iex -S mix` - Run system on host with Elixir shell
- `mix test` - Run unit tests
- `mix format` - Format code
- `mix dialyzer` - Perform type checking
- `mix firmware` - Create firmware image
- `mix burn` - Burn the firmware image to an SD card
- `mix upload` - Upload firmware image to a network-connected device

## Installation

- Install programming languages (versions specified in `.tool-versions`) if you are using `asdf`:

```sh
asdf plugin add erlang
asdf plugin add elixir
asdf install
```

- [Install Nerves](https://hexdocs.pm/nerves/installation.html#content)
- Fetch dependencies:

```sh
MIX_TARGET=rpi0 mix deps.get
```

[next](firmware.md)
