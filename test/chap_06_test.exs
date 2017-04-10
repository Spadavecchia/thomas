defmodule Chap06Test do
  use ExUnit.Case, async: true
  import Chap06

  test "triple" do
    assert triple(111) == 333
  end

  test "quadruple" do
    assert quadruple(111) == 444
  end

  test "factorial" do
    assert factorial(0) == 1
    assert factorial(3) == 6
    assert factorial(5) == 120
    assert factorial(7) == 5040
    assert catch_error(factorial(-8)) == :function_clause
  end

  test "sum_n" do
    assert sum_n(0) == 0
    assert sum_n(2000) == 2_001_000
  end

  test "gcd" do
    assert gcd(8, 12) == 4
  end

  test "guest" do
    assert guess(1, 1..1) == [1]
    assert guess(10, 1..10) == [10]
    assert guess(7, 1..10) == [7, 7, 5]
    assert guess(273, 1..1000) == [273, 273, 265, 281, 312, 375, 250, 500]
  end
end
