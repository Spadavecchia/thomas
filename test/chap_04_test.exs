defmodule Chap04Test do
  use ExUnit.Case, async: true

  describe "value types" do
    test "integers" do
      assert 0xcafe == 51966 # hexa
      assert 0o765 == 501 # octal
      assert 0b1001 == 9 # binary
      assert 1_000_000 == 1000000
    end

    test "floating point" do
      refute 0.2 + 0.1 == 0.3
      assert_in_delta 0.2 + 0.1, 0.3, 0.0000000000000001
    end

    test "atoms" do
      assert :hello == :hello
    end

    test "ranges" do
      result = 1..10
      |> Enum.map(&(&1 * 2))
      assert result == [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
    end

    test "regular expressions" do
      str = "llovia torrencialmente y en la estancia del horcon"
      result = Regex.scan ~r{[aeiou]}, str
      assert result == [["o"], ["i"], ["a"], ["o"], ["e"], ["i"], ["a"],
                        ["e"], ["e"], ["e"], ["a"], ["e"], ["a"], ["i"],
                        ["a"], ["e"], ["o"], ["o"]]
      assert Regex.run(~r{[aeiou]}, str) == ["o"]
    end
  end

  describe "system types" do
    # pids: reference local or remote process
    # ports: reference to a resource to read or write
    # references: globally unique reference created by make_ref
  end

  describe "collection types" do
    test "tuples" do
      assert {1, 2} == {1, 2}
      t = {:ok, 42, "next"}
      assert {:ok, 42, "next"} == t
      {status, count, action} = t
      assert status == :ok
      assert count == 42
      assert action == "next"

      result = File.open("non-existent-file")
      assert result == {:error, :enoent}
    end

    test "lists" do
      # easy to traverse linearly, but expensive to access in random order
      assert [1, 2, 3] ++ [4, 5, 6] == [1, 2, 3, 4, 5, 6]
      assert [1, 2, 3, 4] -- [2, 3] == [1, 4]
      assert 1 in [1, 2, 3, 4]
      refute 5 in [1, 2, 3, 4]
    end

    test "keyword list" do
      # list of two-value tuples
      assert [name: "Tony", age: 139] == [{:name, "Tony"}, {:age, 139}]
      assert [1, name: "Tony", age: 139] == [1, {:name, "Tony"}, {:age, 139}]
    end

    test "map" do
      tony = %{:name => "Tony", :age => 139}
      assert %{:name => "Tony", :age => 139} == %{name: "Tony", age: 139}
      states = %{AL: "Alabama", WI: "Wisconsin"}
      assert states[:AL] == "Alabama"
      assert states[:TX] == :nil
      assert tony.name == "Tony"
      assert {:badkey, :full_name, _} = catch_error(tony.full_name)
    end

    test "binaries" do
      bin = << 1, 2 >>
      assert byte_size(bin) == 2
    end

    test "date and time" do
      d1 = Date.new(2096, 12, 12)
      assert d1 == {:ok, ~D[2096-12-12]}

      t1 = Time.new(12, 15, 55, 456789)
      assert t1 == {:ok, ~T[12:15:55.456789]}
    end

    test "boolean operators" do
      a = 23
      b = a == 22
      refute b
      assert b or a # true if b is true, otherwise a do
      refute b and a

      assert a || b == 23
      refute a && b
    end
  end

  describe "with operator" do
    test "with" do
      content = "External content"
      lp = with {:ok, file}   = File.open("/etc/passwd"),
                content       = IO.read(file, :all),
                :ok           = File.close(file),
                [_, uid, gid] = Regex.run(~r{lp:.*:(\d+):(\d+)}, content)
      do
        "Group: #{gid}, User: #{uid}"
      end
      assert lp == "Group: 7, User: 7"
      assert content == "External content"
    end

    test "with pattern matching" do # Using <- instead of =
      result = with {:ok, file}   =  File.open("/etc/passwd"),
                    content       =  IO.read(file, :all),
                    :ok           =  File.close(file),
                    [_, uid, gid] <- Regex.run(~r{xxx:.*:(\d+):(\d+)}, content)
      do
        "Group: #{gid}, User: #{uid}"
      end
      assert result == :nil
    end

    test "with shortcut" do
      values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      avg = with count = Enum.count(values),
                 sum = Enum.sum(values),
        do: sum / count
      assert avg == 5.5
    end
  end
end
