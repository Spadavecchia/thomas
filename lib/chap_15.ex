defmodule Chap15 do
  @moduledoc """
  Working with Multiple Processes
  """
  # import :timer, only: [sleep: 1]

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

  def pmap(col, fun) do
    me = self()
    col
    |> Enum.map(fn (elem) ->
      spawn_link fn ->
        # sleep(:rand.uniform(20))
        (send me, {self(), fun.(elem)})
      end
    end)
    |> Enum.map(fn (pid) ->
      receive do {^pid, result} -> result end
    end)
  end
end
