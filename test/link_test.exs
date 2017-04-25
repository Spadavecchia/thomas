defmodule LinkTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import :timer, only: [sleep: 1]

  test "run spawn without linking to current process" do
    msg = ~r{MESSAGE RECEIVED: \{:EXIT, #PID<\d\.\d*\.\d>, :boom\}\n}
    assert Regex.match?(msg, capture_io(&Link.run/0))
  end

  test "run a process after dead of span" do
    pid = spawn_link(Link, :kill_process, [])
    send pid, self()
    sleep 500

    assert_receive {:ok, "Exiting without occurrences"}
  end
end
