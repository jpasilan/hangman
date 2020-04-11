defmodule Hangman.Application do
  use Application

  def start(_type, _args) do
    Supervisor.start_link(
      [
        # Use DynamicSupervisor in place of :simple_one_for_one strategy.
        {DynamicSupervisor, strategy: :one_for_one, name: Hangman.Supervisor},
      ],
      [
        strategy: :one_for_one,
      ]
    )
  end

end
