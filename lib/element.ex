defmodule Element do
  use Application

  # @impl true
  def start(_type, _args) do
    # Define the children that will be supervised
    children = [
      # {Element.File, "/tmp/test"}
      # {Registry, name: Element, keys: :unique},
      # {DynamicSupervisor, name: Element.FileSupervisor, strategy: :one_for_one}
      # {Element.File.DynamicSupervisor, name: Element.FileSupervisor, strategy: :one_for_one}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  # # FIXME This doesn't work, presumably because you need more arguments to create an Element.File
  # def create_file(name) do
  #   # DynamicSupervisor.start_child(
  #   #   Element.FileSupervisor,
  #   #   {Element.File, name: via(name)}
  #   # )
  #   Element.File.DynamicSupervisor.start_child()
  # end

  # def lookup_file(name) do
  #   GenServer.whereis(via(name))
  # end

  # defp via(name), do: {:via, Registry, {Element, name}}
end
