# TextClient

A CLI client for the Hangman game.

## Build

Build an executable with the `mix` command below. The executable `text_client` can located within the project directory.

```bash
mix escript.build
```

# Running

Run `./text_client` with either `--sname` or `--name` switches indicating the client host node. A hangman server running at `hangman@localhost` node is assumed to be already running.
