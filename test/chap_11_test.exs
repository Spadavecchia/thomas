defmodule Chap11Test do
  use ExUnit.Case, async: true
  import Chap11

  test "only_printable?" do
    assert only_printable?(' murcielago~')
    refute only_printable?('áéíóú')
  end

  test "anagram?" do
    assert anagram?('', '')
    assert anagram?('cosa', 'saco')
    refute anagram?('acosa', 'saco')
  end

  test "string calculator" do
    assert calculate('') == 0
    assert calculate('1 + 2') == 3
    assert calculate('123 + 256') == 379
    assert calculate('1230 - 30') == 1200
    assert calculate('25 * 4') == 100
    assert calculate('129 / 3') == 43
  end
end
