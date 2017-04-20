defmodule Chap12Test do
  use ExUnit.Case, async: true
  import Chap12

  test "FizzBuzz" do
    assert fizzbuzz(20) == [
      1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz",
      13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
  end

  test "FizzWord" do
    assert fizzword(20) == [
      1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz",
      13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
  end

  test "FizzCase" do
    assert fizzcase(20) == [
      1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz",
      13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
  end
end
