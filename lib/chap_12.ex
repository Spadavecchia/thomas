defmodule Chap12 do
  @moduledoc """
  Control Flow
  """

  def fizzbuzz(n), do: 1..n |> Enum.map(&do_fizzbuzz/1)
  defp do_fizzbuzz(n) do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      rem(n, 3) == 0 -> "Fizz"
      rem(n, 5) == 0 -> "Buzz"
      true -> n
    end
  end

  def fizzword(n), do: 1..n |> Enum.map(&(do_fizz(&1, rem(&1, 3), rem(&1, 5))))
  defp do_fizz(_, 0, 0), do: "FizzBuzz"
  defp do_fizz(_, 0, _), do: "Fizz"
  defp do_fizz(_, _, 0), do: "Buzz"
  defp do_fizz(n, _, _), do: n

  def fizzcase(n), do: 1..n |> Enum.map(&do_fizzcase/1)
  defp do_fizzcase(n) do
    case {n, rem(n, 3), rem(n, 5)} do
      {_, 0, 0} -> "FizzBuzz"
      {_, 0, _} -> "Fizz"
      {_, _, 0} -> "Buzz"
      {n, _, _} -> n
    end
  end
end
