defmodule Chap14 do
  @moduledoc """
  Tooling
  """

  def stats_sum(vals), do: vals |> Enum.reduce(0, &(&1 + &2))

  def stats_count(vals), do: vals |> length

  def stats_average(vals), do: stats_sum(vals) / stats_count(vals)
end
