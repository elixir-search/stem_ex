# StemEx Readme

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

## References

This implementation is based on an earlier [erlang
implementation](https://tartarus.org/martin/PorterStemmer).

* [Overview HTML        ](https://tartarus.org/martin/PorterStemmer               )
* [Overview Text        ](https://tartarus.org/martin/PorterStemmer/def.txt       )
* [Erlang Implementation](https://tartarus.org/martin/PorterStemmer/porter.erl    )
* [Erlang Utilities     ](https://tartarus.org/martin/PorterStemmer/conditions.erl)
* [Test Input           ](https://tartarus.org/martin/PorterStemmer/voc.txt       )
* [Test Output          ](https://tartarus.org/martin/PorterStemmer/output.txt    )

## Escript Installation

If you have Elixir 1.3+ enter this at the console:

<pre><sub>mix escript.install https://raw.githubusercontent.com/andyl/stem_ex/master/stem_ex</sub></pre>


## Package Installation

Add `stem_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:stem_ex, "~> 0.0.2"}]
end
```

Ensure `stem_ex` is started before your application:

```elixir
def application do
  [applications: [:stem_ex]]
end
```

## Source

<https://github.com/andyl/stem_ex> 
