defmodule StemEx.ConditionsTest do

  use ExUnit.Case, async: true

  doctest StemEx.Conditions

  # ----- measure tests -----
  
  vals = [ 
     ["tr"      , 0],
     ["ee"      , 0],
     ["tree"    , 0],
     ["y"       , 0],
     ["by"      , 0],
     ["trouble" , 1],
     ["oats"    , 1],
     ["trees"   , 1],
     ["ivy"     , 1],
     ["troubles", 2],
     ["private" , 2],
     ["oaten"   , 2],
     ["orrery"  , 2],
  ]

  def measure(input) do
    StemEx.Conditions.measure(input, word_dir: :fwd)
  end

  for [input, mscore] <- vals do
    @input  input
    @mscore mscore
    test "measure: '#{input}' has mscore of #{mscore}" do
      assert measure(@input) == @mscore
    end
  end

  # ----- asdf tests -----
  
end
