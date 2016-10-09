defmodule StemExTest do
  use ExUnit.Case, async: true

  doctest StemEx

  test "stem transformations" do
    input_list  = String.split(File.read!("test/data/voc.txt")   , "\n")
    output_list = String.split(File.read!("test/data/output.txt"), "\n")
    io_list     = List.zip([input_list, output_list])
    for {input, output} <- io_list do
      assert StemEx.stem(input) == output
    end
  end
end