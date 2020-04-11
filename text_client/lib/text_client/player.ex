defmodule TextClient.Player do

  alias TextClient.{Mover, Prompter, State, Summary}

  def play(%State{ tally: %{ game_state: :won, word: word }, game_service: game_service }) do
    exit_with_message("You WON!", word, game_service)
  end

  def play(%State{ tally: %{ game_state: :lost, word: word }, game_service: game_service }) do
    exit_with_message("Sorry, you lost.", word, game_service)
  end

  def play(game = %State{ tally: %{ game_state: :good_guess } }) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess } }) do
    continue_with_message(game, "Sorry, that letter isn't in the word.")
  end

  def play(game = %State{ tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "You've already used that letter.")
  end

  def play(game) do
    continue(game)
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(message, word, game_service) do
    message = [
      message,
      " ",
      "Word is \"#{word}\".",
    ]

    IO.puts(message)
    :rpc.call(TextClient.Interact.hangman_server, Hangman, :exit_game, [game_service])
    exit(:normal)
  end

end
