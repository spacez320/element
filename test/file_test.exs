defmodule Element.FileTest do
  use ExUnit.Case, async: true

  @tag :tmp_dir
  test "writes to a file", %{tmp_dir: tmp_dir} = config do
    test_path = Path.join(tmp_dir, Atom.to_string(config.test))
    test_name = String.to_atom(test_path)

    {:ok, file} = Element.File.start_link(name: test_name)
    assert Element.File.get(test_name) == nil

    Element.File.put(file, "foo")
    assert Element.File.get(test_name) == "foo"
  end

  @tag :tmp_dir
  test "deletes a file and returns its contents", %{tmp_dir: tmp_dir} = config do
    test_path = Path.join(tmp_dir, Atom.to_string(config.test))
    test_name = String.to_atom(test_path)

    {:ok, file} = Element.File.start_link(name: test_name)
    Element.File.put(file, "foo")
    {:ok, _stat} = File.stat(test_path)
    assert Element.File.delete(file) == "foo"
  end
end
