defmodule Chap08 do
  @moduledoc """
  Maps, Keyword Lists, Sets and Structs
  """

  def book(%{name: name, height: height}) when height > 1.9 do
    "Need extra long bed for #{name}"
  end
  def book(%{name: name, height: height}) when height < 1.3 do
    "Need low shower controls for #{name}"
  end
  def book(person) do
    "Need regular bed for #{person.name}"
  end
end
