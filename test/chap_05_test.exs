defmodule Chap05Test do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  test "simple anonymous function" do
    f = fn (a, b) -> a + b end
    assert f.(5, 4) == 9
    f2 = &(&1 + &2)
    assert f2.(5, 4) == 9
  end

  test "pattern matching parameter" do
    swap = fn({a, b}) -> {b, a} end
    assert swap.({1, 2}) == {2, 1}
  end

  test "list_concat" do
    list_concat = &(&1 ++ &2)
    assert list_concat.([:a, :b], [:c, :d]) == [:a, :b, :c, :d]
  end

  test "sum" do
    sum = &(&1 + &2 + &3)
    assert sum.(1, 2, 3) == 6
  end

  test "pair_tuple_to_list" do
    pair_tuple_to_list = fn {a, b} -> [a, b] end
    assert pair_tuple_to_list.({1234, 5678}) == [1234, 5678]
  end

  test "multiple bodies for function" do
    handle_open = fn
      {:ok, file} -> "Read data: #{IO.read(file, :line)}"
      {_, error} -> "Error: #{:file.format_error(error)}"
    end
    assert "/etc/passwd"
      |> File.open()
      |> handle_open.()
      |> String.contains?("Read dat")
    assert "/not-exists"
      |> File.open()
      |> handle_open.()
      |> String.contains?("Error:")
  end

  test "fizzbuzz" do
    do_fizzbuzz = fn
      0, 0, _ -> "FizzBuzz"
      0, _, _ -> "Fizz"
      _, 0, _ -> "Buzz"
      _, _, n -> n
    end

    fizzbuzz = fn n -> do_fizzbuzz.(rem(n, 3), rem(n, 5), n) end
    assert fizzbuzz.(10) == "Buzz"
    assert fizzbuzz.(11) == 11
    assert fizzbuzz.(12) == "Fizz"
    assert fizzbuzz.(13) == 13
    assert fizzbuzz.(14) == 14
    assert fizzbuzz.(15) == "FizzBuzz"
    assert fizzbuzz.(16) == 16
  end

  describe "closure" do
    test "closure" do
      greeter = fn name -> fn -> "Hello #{name}" end end
      assert greeter.("Tony").() == "Hello Tony"

      add_n = fn n -> fn other -> n + other end end
      add_two = add_n.(2)
      add_five = add_n.(5)
      assert add_two.(7) == 9
      assert add_five.(5) == 10
    end

    test "prefix" do
      prefix = fn p -> fn text -> "#{p} #{text}" end end

      mrs = prefix.("Mrs")
      assert mrs.("Smith") == "Mrs Smith"
      elixir = prefix.("Elixir")
      assert elixir.("Rocks") == "Elixir Rocks"
    end
  end

  test "fn shortcut notation" do
    assert Enum.map([1, 2, 3, 4], &(&1 + 2)) == [3, 4, 5, 6]
    io = fn -> Enum.each([1, 2, 3, 4], &IO.inspect/1) end
    assert capture_io(io) == "1\n2\n3\n4\n"
  end
end
