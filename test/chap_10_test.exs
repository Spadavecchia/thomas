defmodule Chap10Test do
  use ExUnit.Case, async: true
  require Integer
  import Chap10

  test "Enum" do
    assert Enum.to_list(1..10) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    assert Enum.concat([1, 2], [3, 4]) == [1, 2, 3, 4]
    assert Enum.map(1..5, &(&1 * 2)) == [2, 4, 6, 8, 10]
    assert Enum.at(1..5, 2) == 3
    assert Enum.filter(1..10, &Integer.is_even/1) == [2, 4, 6, 8, 10]
    assert Enum.reject(1..10, &Integer.is_even/1) == [1, 3, 5, 7, 9]
    sentence = ["there", "was", "a", "man"]
    assert Enum.sort(sentence) == ["a", "man", "there", "was"]
    assert Enum.sort(sentence, &(String.length(&1) < String.length(&2))) ==
      ["a", "man", "was", "there"]
    assert Enum.max(sentence) == "was"
    assert Enum.max_by(sentence, &String.length/1) == "there"
    assert Enum.take(1..10, 3) == [1, 2, 3]
    assert Enum.take_every(1..10, 3) == [1, 4, 7, 10]
    assert Enum.take_while(1..10, &(&1 < 4)) == [1, 2, 3]
    assert Enum.split(1..10, 4) == {[1, 2, 3, 4], [5, 6, 7, 8, 9, 10]}
    assert Enum.split_while(1..10, &(&1 > 6)) ==
      {[], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}
    assert Enum.split_while(1..10, &(&1 < 6)) ==
      {[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]}
    assert Enum.join(1..10) == "12345678910"
    assert Enum.join(1..10, ", ") == "1, 2, 3, 4, 5, 6, 7, 8, 9, 10"
    refute Enum.all?(1..10, &(&1 < 10))
    assert Enum.any?(1..10, &(&1 < 10))
    assert Enum.member?(1..10, 3)
    refute Enum.empty?(1..10)
    assert Enum.zip(1..3, [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
    assert Enum.with_index(1..3) == [{1, 0}, {2, 1}, {3, 2}]
    assert Enum.reduce(1..100, &(&1 + &2)) == 5050
  end

  test "my_all?" do
    assert my_all?([], &Integer.is_odd/1)
    refute my_all?([1, 2, 3, 4, 5], &Integer.is_odd/1)
    assert my_all?([1, 3, 5], &Integer.is_odd/1)
  end

  test "my_filter" do
    assert my_filter([], &Integer.is_odd/1) == []
    assert my_filter([1, 2, 3, 4], &Integer.is_odd/1) == [1, 3]
    assert my_filter([1, 2, 3, 4], &(&1 > 5)) == []
  end

  test "my_flatten" do
    assert my_flatten([]) == []
    assert my_flatten([1, 2, 3]) == [1, 2, 3]
    assert my_flatten([1, [2, 3]]) == [1, 2, 3]
    assert List.flatten([1, [2, 3, [4, [[5]], 6], 7], 8]) ==
      [1, 2, 3, 4, 5, 6, 7, 8]
    assert my_flatten([1, [2, 3, [4, [[5]], 6], 7], 8]) ==
      [1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "Stream" do
    odds = 1..20
      |> Stream.map(&(&1 * &1))
      |> Stream.map(&(&1 + 1))
      |> Stream.filter(&Integer.is_odd/1)
      |> Enum.to_list
    assert odds == [5, 17, 37, 65, 101, 145, 197, 257, 325, 401]

    four = 1..10_000_000
      |> Stream.map(&(&1 + 1))
      |> Enum.take(4)
    assert four == [2, 3, 4, 5]

    elements = ~w{ green white }
      |> Stream.cycle
      |> Enum.take(4)
    assert elements == ~w{ green white green white }

    f = fn -> 3 end
    reps = f
      |> Stream.repeatedly
      |> Enum.take(4)
    assert reps == [3, 3, 3, 3]

    progression = 1
      |> Stream.iterate(&(&1 + &1))
      |> Enum.take(6)
    assert progression == [1, 2, 4, 8, 16, 32]

    fibonacci = {0, 1}
      |> Stream.unfold(fn {x, y} -> {x, {y, x + y}} end)
      |> Enum.take(9)
    assert fibonacci == [0, 1, 1, 2, 3, 5, 8, 13, 21]
  end

  test "Comprehension" do
    by_map = 1..9 |> Enum.filter(&(&1 >= 5)) |> Enum.map(&(&1 * &1))
    by_com = for x <- 1..9, x >= 5, do: x * x
    assert by_map == by_com

    cartesian = for i <- 3..5, j <- 10..12, do: i * j
    assert cartesian == [30, 33, 36, 40, 44, 48, 50, 55, 60]

    min_max = [{1, 4}, {2, 3}, {10, 15}]
    reused = for {min, max} <- min_max, n <- min..max, do: n
    assert reused == [1, 2, 3, 4, 2, 3, 10, 11, 12, 13, 14, 15]

    ten_mul = for x <- 1..8, y <- 1..8, x >= y, rem(x * y, 10) == 0, do: {x, y}
    assert ten_mul == [{5, 2}, {5, 4}, {6, 5}, {8, 5}]

    rep = [dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy]
    swa = for {city, weather} <- rep, do: {weather, city}
    assert swa == [hot: :dallas, cold: :minneapolis, muggy: :dc, smoggy: :la]
  end

  test "Binary Comprehension" do
    assert (for << ch <- "hello" >>, do: ch) == 'hello'
    assert (for << ch <- "hello" >>, do: <<ch>>) == ["h", "e", "l", "l", "o"]
  end

  # test "primes" do
  #   assert [] == primes([])
  #   assert [1] == primes([1])
  #   assert [1, 2] == primes([1, 2])
  #   # assert [1, 2, 3, 5, 7] == primes(1..10)
  # end

  test "taxes" do
    # tax_rates = [ NC: 0.075, TX: 0.08 ]
    # orders = [
    #   [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    #   [ id: 124, ship_to: :OK, net_amount: 35.50 ],
    #   [ id: 125, ship_to: :TX, net_amount: 24.00 ],
    #   [ id: 126, ship_to: :TX, net_amount: 44.80 ],
    #   [ id: 127, ship_to: :NC, net_amount: 25.00 ],
    #   [ id: 128, ship_to: :MA, net_amount: 10.00 ],
    #   [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    #   [ id: 130, ship_to: :NC, net_amount: 50.00 ]]

    # taxes = for {} <- orders, { city, tax } <- tax_rates, o.ship_to == city do
    #   [{:total_amount,  }]
    # end
  end
end
