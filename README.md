# StemEx

Porter stemming algorithm implementation in Elixir

The basic philosophy behind this implementation is to map the structure of
Martin Porter's original description of his algorithm
(http://tartarus.org/~martin/PorterStemmer) as closely as possible into Elixir.
I made liberal use of Elixir's pattern matching facility. In order for this to
work, there is one quirk - the word to be matched must be reversed before it is
stemmed: "hopping" becomes "gnippoh". This is necessary because Elixir's
pattern matching won't work with Stem ++ "ing" but instead requires "gni" ++
Rstem (where Rstem is the reversed stem).  Despite this quirk, the flipping the
words allowed me to greatly simplify the rest of the coding, almost to the
point of being a tedious translation of the textual description of the
algorithm.

References:
(Overview HTML )[https://tartarus.org/martin/PorterStemmer]
(Overview Text )[https://tartarus.org/martin/PorterStemmer/def.txt]
(Test Input    )[https://tartarus.org/martin/PorterStemmer/voc.txt]
(Test Output   )[https://tartarus.org/martin/PorterStemmer/output.txt]
(Erlang App    )[https://tartarus.org/martin/PorterStemmer/porter.erl]
(Erlang App    )[https://tartarus.org/martin/PorterStemmer/conditions.erl]

## Installation

To install the package:

  1. Add `stem_ex` to your list of dependencies in `mix.exs`:

    From Hex (not yet ready!!!)
    ```elixir
    def deps do
      [{:stem_ex, "~> 0.1.0"}]
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

