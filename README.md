# StemEx

Porter stemming algorithm implementation in Elixir

The basic philosophy behind this implementation is to map the structure of
Martin Porter's original description of his
[algorithm](http://tartarus.org/~martin/PorterStemmer) as closely as possible
into Elixir.  The code makes liberal use of Elixir's pattern matching facility.
In order for this to work, there is one quirk - the word to be matched must be
reversed before it is stemmed: "hopping" becomes "gnippoh". This is necessary
because Elixir's pattern matching won't work with `stem <> "ing"` but instead
requires `"gni" <> rstem` (where `rstem` is the reversed stem).  Despite this
quirk, the flipping the words allowed us to greatly simplify the rest of the
coding, almost to the point of being a tedious translation of the textual
description of the algorithm.

## Installation

To install the escript (Elixir > 1.4):

`mix escript.install hex stem_ex`

To install the package:

  1. Add `stem_ex` to your list of dependencies in `mix.exs`:

    From Hex:

    ```elixir
    def deps do
      [{:stem_ex, "~> 0.0.1"}]
    end
    ```

    From GitHub:

    ```elixir
    def deps do
      [{:stem_ex, git: "git://github.com/andyl/stem_ex.git"}]
    end
    ```

  2. Ensure `stem_ex` is started before your application:

    ```elixir
    def application do
      [applications: [:stem_ex]]
    end
    ```

