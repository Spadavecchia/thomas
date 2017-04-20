defmodule Chap11 do
  @moduledoc """
  String and Binaries
  """

  @doc """
  true when all characters are printables
  """

  def only_printable?(s), do: Enum.all? s, &(&1 in 32..126)

  def anagram?(s1, s2), do: Enum.sort(s1) == Enum.sort(s2)

  def calculate(''), do: 0
  def calculate(s), do: s |> to_string |> String.split |> do_calculate
  defp do_calculate([n1, op, n2]) do
    i1 = String.to_integer(n1)
    i2 = String.to_integer(n2)
    case op do
      "+" -> i1 + i2
      "-" -> i1 - i2
      "*" -> i1 * i2
      "/" -> i1 / i2
    end
  end
end
