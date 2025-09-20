defmodule State do
  use Agent

  def start_link(file) do
    Agent.start_link(fn -> %{:file => file, :contents => File.read(file)} end)
  end

  def get(state) do
    # IO.puts(Agent.get(:foo, &Map.get(&1, :contents)))
    Agent.get(state, &Map.get(&1, :contents))
  end

  def put(state, contents) do
    File.write(&Map.get(&1, :file), contents)
    Agent.update(state, &Map.update!(&1, :contents, fn -> contents end))
  end

  # defp loop(file) do
  #   receive do
  #     {:get, caller} ->
  #       {:ok, contents} = File.read(file)
  #       send(caller, contents)
  #
  #     {:put, contents} ->
  #       File.write(file, contents)
  #       loop(file)
  #   end
  # end
end
