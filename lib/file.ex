defmodule Element.File do
  use Agent

  def start_link(opts) do
    {:via, Registry, {Element.File, file_path}} = opts[:name]

    Agent.start_link(
      fn ->
        case File.read(file_path) do
          {:ok, contents} -> %{contents: contents, file: file_path}
          {:error, :enoent} -> %{contents: nil, file: file_path}
        end
      end,
      opts
    )
  end

  def delete(file) do
    Agent.get_and_update(file, fn state ->
      :ok = File.rm(Map.get(state, :file))
      {Map.get(state, :contents), Map.put(state, :contents, nil)}
    end)
  end

  def get(file) do
    Agent.get(file, &Map.get(&1, :contents))
  end

  def put(file, contents) do
    Agent.update(file, fn state ->
      :ok = File.write(Map.get(state, :file), contents)
      Map.put(state, :contents, contents)
    end)
  end
end

# defmodule Element.File.DynamicSupervisor do
#   use DynamicSupervisor
#
#   def start_link(_arg) do
#     DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
#   end
#
#   @impl true
#   def init(:ok) do
#     DynamicSupervisor.init(strategy: :one_for_one)
#   end
#
#   def start_child() do
#     child_spec = %{
#       id: Element.File,
#       start: {Element.File, :start_link, []}
#     }
#
#     DynamicSupervisor.start_child(__MODULE__, child_spec)
#   end
# end
