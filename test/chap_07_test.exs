defmodule Chap07Test do
  use ExUnit.Case, async: true
  import Chap07

  test "lists" do
    assert [1 | [2 | [3 | []]]] == [1, 2, 3]
    assert [2, 3] == with [ _ | t ] <- [1, 2, 3], do: t
    f = with [_ | t] <- [1, 2, 3],
             [_ | t1] <- t,
             [_ | t2] <- t1, do: t2
    assert f == []
  end

  test "square" do
    assert square([2, 4, 6, 8]) == [4, 16, 36, 64]
  end

  test "map" do
    assert map([2, 4, 6], &(&1 * &1)) == [4, 16, 36]
  end

  test "sum" do
    assert sum_list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 55
  end

  test "sum_col" do
    assert sum_col([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 55
  end

  test "reduce" do
    assert reduce([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], &(&1 + &2), 0) == 55
  end

  test "mapsum" do
    assert mapsum([1, 2, 3], &(&1 * &1)) == 14
  end

  test "max" do
    assert max_super([]) == :nil
    assert max_super([1]) == 1
    assert max_super([3, 7, 2, 11, 1, 4]) == 11
    assert max_super([110, -3, 7, 2, 11, 1, 4]) == 110
  end

  test "caesar" do
    assert caesar('', 13) == ''
    assert caesar('ryvkve', 13) == 'elixir'
  end

  test "swap" do
    assert swap([]) == []
    assert catch_error(swap([1])).message != :nil
    assert swap([2, 1, 4, 3]) == [1, 2, 3, 4]
  end

  test "location" do
    test_data = [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.15],
      [1366228622, 26, 21, 0.25],
      [1366229622, 28, 15, 0.12],
      [1366220622, 26, 15, 0.25],
      [1366725622, 27, 19, 0.15],
      [1366825622, 26, 15, 0.12],
      [1366925622, 28, 15, 0.125],
      [1366025622, 27, 15, 0.25],
      [1367225622, 26, 15, 0.15],
    ]

    assert for_location([], 27) == []
    assert (test_data |> for_location(55) |> length) == 0
    assert (test_data |> for_location(28) |> length) == 2
    assert (test_data |> for_location(27) |> length) == 3
    assert (test_data |> for_location(26) |> length) == 5
  end

  test "span" do
    assert span(0, 0) == [0]
    assert span(0, 1) == [0, 1]
    assert span(0, 5) == [0, 1, 2, 3, 4, 5]
    assert span(-10, -5) == [-10, -9, -8, -7, -6, -5]
  end
end
