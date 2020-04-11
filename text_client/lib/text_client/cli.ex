defmodule TextClient.CLI do

  def main(args) do
    options = [
      switches: [
        [sname: :string],
        [name:  :string],
      ]
    ]

    {opts, _, _} = OptionParser.parse(args, options)

    start(opts)
  end

  def start([sname: name]) do
    name |> String.to_atom() |> Node.start(:shortnames)
    TextClient.start()
  end

  def start([name: name]) do
    name |> String.to_atom() |> Node.start()
    TextClient.start()
  end

  def start(_) do
    [
      "Usage: ./text_client --switch value\n",
      "Switches:\n",
      "  --sname Short name node\n",
      "  --name  Long name node",
    ] |> IO.puts()
  end

end

