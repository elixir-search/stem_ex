defmodule StemEx.CLI do
  @moduledoc "Simple CLI - takes a word and returns the stemmed transformation"

  @doc """
  Entry point for `stem_ex` executable.  Takes a single argument `argv`.
  """
  def main(argv) do
    case argv do
      [word]          -> IO.puts StemEx.stem(word)
      []              -> usage()
      _               -> usage()
    end
  end

  # -------------------------------------------------------------------

  defp version, do: StemEx.App.version

  defp prog do
    StemEx.App.name
  end

  defp usage do
    IO.puts usage_message()
  end

  defp usage_message do
    "USAGE: #{prog()} <word>\n(#{prog()} #{version()})"
  end
end

