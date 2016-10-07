defmodule StemEx do
  @moduledoc """
  Porter stemming algorithm implementation in Elixir
  """

  def stem(word) when length(word) > 2 do
    reverse(word)
    |> step1
    |> step2
    |> step3
    |> step4
    |> step5
    |> reverse
  end


  def stem_file do
  end
end
