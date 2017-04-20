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
  end
end
