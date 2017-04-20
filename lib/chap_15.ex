defmodule Chap15 do
  @moduledoc """
  Working with Multiple Processes
  """

  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, #{msg}!"}
        greet()
    end
  end

  def ping do
    receive do
      {sender, :pong} ->
        send sender, {sender, :ping}
        ping()
    end
  end
end
