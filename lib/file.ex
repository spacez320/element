defmodule Element.File do
  use Agent

  def start_link(opts, file) do
    Agent.start_link(
      fn ->
        case File.read(file) do
          {:ok, contents} -> %{contents: contents, file: file}
          {:error, :enoent} -> %{contents: nil, file: file}
        end
      end,
      opts
    )
  end

  def delete(file) do
    Agent.get_and_update(file, fn s ->
      :ok = File.rm(Map.get(s, :file))
      {Map.get(s, :contents), Map.put(s, :contents, nil)}
    end)
  end

  def get(file) do
    Agent.get(file, &Map.get(&1, :contents))
  end

  def put(file, contents) do
    Agent.update(file, fn s ->
      :ok = File.write(Map.get(s, :file), contents)
      Map.put(s, :contents, contents)
    end)
  end
end
