defmodule StemEx.App do
  @moduledoc false

  @doc """
  Return the application version

  ## Example

      iex> StemEx.App.version
      '0.0.1'
  """
  def version do
    appsym = symbol
    appver = fn
        [{_app, _desc, vsn}] -> vsn
        _                    -> "NA"
    end
    Application.loaded_applications
    |> Enum.filter(fn({atom, _, _}) -> atom == appsym end)
    |> appver.()
  end

  @doc """
  Return the application symbol.

  ## Example

      iex> StemEx.App.symbol
      :stem_ex
  """
  def symbol do
    Application.get_application(__MODULE__)
  end

  @doc """
  Return the application name.

  ## Example

      iex> StemEx.App.name
      "stem_ex"
  """
  def name do
    Atom.to_string(symbol)
  end
end

