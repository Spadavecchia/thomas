defmodule Chap02Test do
  use ExUnit.Case, async: true

  test "matching listing" do
    assert a = 1
    assert 1 = a
    # assert 2 = a Failing
  end

  test "matching list" do
    list = [1, 2, 3]
    [a, b, c] = list
    assert a == 1
    assert b == 2
    assert c == 3
  end

  test "matching variables" do
    a = [1, 2, 3]
    assert a == [1, 2, 3]
    a = 4
    assert a == 4
    assert 4 = a

    # [a, b] = [1, 2, 3] # Error
    a = [[1, 2, 3]]
    assert a == [[1, 2, 3]]
    [a] = [[1, 2, 3]]
    assert a == [1, 2, 3]
    # [[a]] = [[1, 2, 3]] # Error
    [a, a] = [1, 1]
    assert a == 1
    # [b, b] = [1, 2] # Error
    a = 1
    assert a == 1
    a = 2
    assert a == 2
    # ^a = 1 # Error
  end

  test "matching with pinned values" do
    # [a, b, a] = [1, 2, 3] # Error
    # [a, b, a] = [1, 1, 2] # Error
    [a, b, a] = [1, 2, 1]
    assert a == 1
    assert b == 2
    a = 2
    assert a == 2
    # [a, b, a] = [1, 2, 3] # Error
    # [a, b, a] = [1, 1, 2] # Error
    a = 1
    assert a == 1
    # ^a = 2 # Error
    ^a = 1
    ^a = 2 - a
  end
end
