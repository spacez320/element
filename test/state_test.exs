defmodule StateTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, state} = State.start_link("foo")
    %{state: state}
  end

  test "syncs state to file", %{state: state} do
    State.get(state)
  end
end
