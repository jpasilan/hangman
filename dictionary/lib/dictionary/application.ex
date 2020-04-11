defmodule Dictionary.Application do
  use Application

  alias Dictionary.WordList

  def start(_type, _args) do
    import Supervisor.Spec

    Supervisor.start_link(
      # children
      [
        worker(WordList, []),
      ],
      # options
      [
        name:     Dictionary.Supervisor,
        strategy: :one_for_one,
      ]
    )
  end

end
