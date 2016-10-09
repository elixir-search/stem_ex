defmodule StemEx do
  @moduledoc """
  Porter stemming algorithm implementation in Elixir
  """

  import StemEx.Steps

  @doc """
  Stem function - takes a word and returns it's stemmed transformation.

  ## Examples
  
      iex> StemEx.stem("x")
      "x"

      iex> StemEx.stem("xy")
      "xy"

      iex> StemEx.stem("cats")
      "cat"

      iex> StemEx.stem("spotting")
      "spot"
  """
  def stem(word) do
    if String.length(word) > 2 do
      word
      |> String.reverse
      |> step1
      |> step2
      |> step3
      |> step4
      |> step5
      |> String.reverse
    else
      word
    end
  end
end
