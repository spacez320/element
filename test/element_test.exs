defmodule ElementTest do
  use ExUnit.Case
  doctest Element

  test "greets the world" do
    assert Element.hello() == :world
  end
end
