defmodule TextClient.Summary do

  alias TextClient.State

  def display(game = %State{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Letters used: #{Enum.join(tally.guesses, "")}\n",
      "Guesses left: #{tally.turns_left}",
      "\n",
    ]
    game
  end

end
