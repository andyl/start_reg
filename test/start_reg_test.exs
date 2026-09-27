defmodule StartRegTest do
  use ExUnit.Case
  doctest StartReg

  test "greets the world" do
    assert StartReg.hello() == :world
  end
end
