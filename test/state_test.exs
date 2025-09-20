defmodule StateTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, state} = State.start_link("/tmp/foo")
    %{state: state}
  end

  test "syncs state to file", %{state: state} do
    assert State.get(state) == {:error, :enoent}
    State.put(state, "test")
    assert State.get(state) == {:ok, "test"}
  end
end
