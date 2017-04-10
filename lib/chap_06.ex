defmodule Chap06 do
  @moduledoc """
  Modules and Functions
  """

  @spec triple(number) :: number
  def triple(x), do: x * 3

  @spec quadruple(number) :: number
  def quadruple(x), do: x * 4

  @spec factorial(integer) :: integer
  def factorial(0), do: 1
  def factorial(n) when n > 0, do: factorial(n - 1) * n

  @spec sum_n(integer) :: integer
  def sum_n(0), do: 0
  def sum_n(n), do: n + sum_n(n - 1)

  @spec gcd(integer, integer) :: integer
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  @spec guess(integer, Range.t) :: list
  def guess(n, range), do: do_guess(n, range, [])
  defp do_guess(n, n.._, r), do: [n | r]
  defp do_guess(n, _..n, r), do: [n | r]
  defp do_guess(n, l..h, r) do
    midpoint = div(l + h, 2)
    range = if n > midpoint, do: midpoint..h, else: l..midpoint
    do_guess(n, range, [midpoint | r])
  end
end
