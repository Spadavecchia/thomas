defmodule Chap10 do
  @moduledoc """
  Enum and Stream
  """

  def my_all?(l, fun), do: do_my_all?(l, fun, true)

  defp do_my_all?(_, _, false), do: false
  defp do_my_all?([], _, true), do: true
  defp do_my_all?([h | t], fun, _), do: do_my_all?(t, fun, fun.(h))

  def my_filter([], _), do: []
  def my_filter([h | t], fun) do
    if fun.(h) do
      [h | my_filter(t, fun)]
    else
      my_filter(t, fun)
    end
  end

  def my_flatten(l), do: do_my_flatten(l, [])
  defp do_my_flatten([h | t], tail) when is_list(h) do
    do_my_flatten(h, do_my_flatten(t, tail))
  end
  defp do_my_flatten([h | t], tail), do: [h | do_my_flatten(t, tail)]
  defp do_my_flatten([], tail), do: tail

  # def primes(n) do
  #   for x <- 2..n, is_prime?(x), do: x
  # end
end
