defmodule Element.FileTest do
  use ExUnit.Case, async: true

  test "writes to a file", config do
    test_file = "/tmp/test"

    File.write(test_file, "foo")

    {:ok, _} = Element.File.start_link([name: config.test], test_file)
    assert Element.File.get(config.test) == "foo"
    Element.File.put(config.test, "bar")
    assert Element.File.get(config.test) == "bar"
    Element.File.put(config.test, "bar2")
    assert Element.File.get(config.test) == "bar2"
  end

  test "removes a file", config do
    test_file = "/tmp/test"

    File.write("/tmp/test", "foo")

    {:ok, _} = Element.File.start_link([name: config.test], test_file)
    assert Element.File.get(config.test) == "foo"
    assert Element.File.delete(config.test) == "foo"
    assert Element.File.get(config.test) == nil
  end
end
