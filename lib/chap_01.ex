defmodule Thomas.Chap01 do
  @moduledoc """
  Take the Red Pill
  """

  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end
