defmodule SumOfCubes do
  @moduledoc """
  Sum of Cubes
  """

  def run do
    receive do
      {sender, n} ->
        data = Enum.reduce 1..n, &(&1 + &2 * &2 * &2)
        send sender, {:ok, data}
    end
  end
end
