defmodule Chap07 do
  @moduledoc """
  List and Recursion
  """

  def square([]), do: []
  def square([h | t]), do: [h * h | square(t)]

  def map([], _), do: []
  def map([h | t], f), do: [f.(h) | map(t, f)]

  def sum_list(l), do: do_sum(l, 0)
  defp do_sum([], total), do: total
  defp do_sum([h | t], total), do: do_sum(t, h + total)

  def sum_col([]), do: 0
  def sum_col([h | t]), do: h + sum_col(t)

  def reduce([], _, total), do: total
  def reduce([h | t], f, total), do: reduce(t, f, f.(h, total))

  def mapsum(l, f), do: do_mapsum(l, f, 0)
  defp do_mapsum([], _, total), do: total
  defp do_mapsum([h | t], f, total), do: do_mapsum(t, f, total + f.(h))

  # def max_super([]), do: :nil
  # def max_super([h | t]), do: do_max_super(t, h)
  # defp do_max_super([], m), do: m
  # defp do_max_super([h | t], m) when h > m, do: do_max_super(t, h)
  # defp do_max_super([_ | t], m), do: do_max_super(t, m)

  def max_super([]), do: :nil
  def max_super([m]), do: m
  def max_super([m | [h | t]]) when m > h, do: max_super([m | t])
  def max_super([_ | [h | t]]), do: max_super([h | t])

  def caesar([], _), do: []
  def caesar([h | t], n) when h + n <= 122, do: [h + n | caesar(t, n)]
  def caesar([h | t], n), do: [(h + n) - 26 | caesar(t, n)]

  def swap([]), do: []
  def swap([a, b | tail]), do: [b, a | swap(tail)]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"

  def for_location([], _), do: []
  def for_location([head = [_, location, _, _] | tail], location) do
    [head | for_location(tail, location)]
  end
  def for_location([_ | tail], location), do: for_location(tail, location)

  def span(from, to) when from == to, do: [from]
  def span(from, to) when from > to, do: [from | span(from - 1, to)]
  def span(from, to), do: [from | span(from + 1, to)]
end
