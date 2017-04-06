defmodule Chap01Test do
  use ExUnit.Case, async: true
  import Thomas.Chap01

  test "pmap process map asynchronous" do
    result = [1, 2, 3, 4, 5]
    |> pmap(&(&1 * 2))

    assert result == [2, 4, 6, 8, 10]
  end
end
