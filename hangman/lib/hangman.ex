defmodule Hangman do

  def new_game() do
    { :ok, pid } = DynamicSupervisor.start_child(
      Hangman.Supervisor,
      # Equivalent to worker(Hangman.Server, []) but needs to import Supervisor.Spec.
      %{id: Hangman.Server, start: {Hangman.Server, :start_link, []}}
    )
    pid
  end

  def tally(game_pid),            do: GenServer.call(game_pid, :tally)
  def make_move(game_pid, guess), do: GenServer.call(game_pid, { :make_move, guess })
  def exit_game(game_pid),        do: send(game_pid, { :exit, { :shutdown, :timeout} })

end
