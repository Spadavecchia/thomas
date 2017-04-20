defmodule Chap14Test do
  use ExUnit.Case, async: true

  describe "Stats on lists of ints" do
    setup do
      [list:  [1, 3, 5, 7, 9, 11],
       sum:   36,
       count: 6
      ]
    end

    test "calculates sum", fixture do
      assert Chap14.stats_sum(fixture.list) == fixture.sum
    end

    test "calculates count", fixture do
      assert Chap14.stats_count(fixture.list) == fixture.count
    end

    test "calculates average", fixture do
      assert Chap14.stats_average(fixture.list) == fixture.sum / fixture.count
    end
  end
end
