defmodule Chap03Test do
  use ExUnit.Case, async: true

  test "immutable list" do
    list1 = [1, 2, 3]
    list2 = [4 | list1]
    assert list2 == [4, 1, 2, 3]
  end

  test "immutable string" do
    str = "hello"
    str2 = String.capitalize str
    assert str2 == "Hello"
  end
end
