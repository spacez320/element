defmodule State do
  use Agent

  def start_link(file) do
    Agent.start_link(fn -> %{:file => file, :contents => File.read(file)} end)
  end

  def get(state) do
    agent_get = fn
      state -> Map.get(state, :contents)
    end

    Agent.get(state, agent_get)
  end

  def put(state, contents) do
    agent_put = fn
      state ->
        file = Map.get(state, :file)
        File.write(file, contents)
        %{:file => file, :contents => File.read(file)}
    end

    Agent.update(state, agent_put)
  end
end
