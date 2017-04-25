defmodule Chap15Test do
  use ExUnit.Case

  describe "Working with Multiple Processes" do
    test "spawn" do
      pid = spawn(Chap15, :greet, [])
      send pid, {self(), "Tony"}
      assert_receive {:ok, "Hello, Tony!"}
      send pid, {self(), "Montana"}
      assert_receive {:ok, "Hello, Montana!"}
    end

    test "respond to a pong with a ping" do
      ping = spawn_link(Chap15, :ping, [])
      send ping, {self(), :pong}
      assert_receive {_sender, :ping}
    end

    test "respond to two pongs with two ping" do
      ping = spawn_link(Chap15, :ping, [])
      send ping, {self(), :pong}
      assert_receive {_sender, :ping}
      send ping, {self(), :pong}
      assert_receive {_sender, :ping}
    end

    test "pmap" do
      result = 1..10
      |> Chap15.pmap(&(&1 * &1))
      assert result == [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
    end
  end
end
