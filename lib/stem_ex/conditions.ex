defmodule StemEx.Conditions do
  @moduledoc false

  @doc """
  Test to see if the letter is a vowel.

  ## Examples
    
      iex> StemEx.Conditions.is_vowel("a")
      true

      iex> StemEx.Conditions.is_vowel("y")
      false

      iex> StemEx.Conditions.is_vowel("y", y_is_vowel: true)
      true

      iex> StemEx.Conditions.is_vowel("y", y_is_vowel: false)
      false

      iex> StemEx.Conditions.is_vowel("x")
      false
  """
  def is_vowel(letter, [y_is_vowel: bool] \\ [y_is_vowel: false]) do
    case letter do
      "a" -> true
      "e" -> true
      "i" -> true
      "o" -> true
      "u" -> true
      "y" -> bool
      _   -> false
    end
  end

  def is_consonant(letter, [y_is_vowel: bool] \\ [y_is_vowel: false]) do
    not is_vowel(letter, y_is_vowel: bool)
  end
  
  @doc """
  Implements m, the measure of a word or word part.

  ## Examples

      iex> StemEx.Conditions.measure("tree", word_dir: :fwd)
      0

      iex> StemEx.Conditions.measure("abba", word_dir: :fwd)
      1

      iex> StemEx.Conditions.measure("oaten", word_dir: :fwd)
      2
  """
  def measure(word, [word_dir: word_dir] \\ [word_dir: :rev]) do
    case word_dir do
      :fwd -> p_measure(word, 0)
      _    -> p_measure(String.reverse(word), 0)
    end
  end

  defp p_measure(<<>>, 0), do: 0
  defp p_measure(<<head::binary-size(1), tail::binary>>, 0) do
    case is_vowel(head) do
      true  -> found_vowel(tail, 0)
      false -> found_leading_consonant(tail)
    end
  end

  defp found_leading_consonant(<<>>), do: 0
  defp found_leading_consonant(<<head::binary-size(1), tail::binary>>) do
    case is_vowel(head, y_is_vowel: true) do
      true  -> found_vowel(tail, 0)
      false -> found_leading_consonant(tail)
    end
  end

  defp found_vowel(<<>>, mcount), do: mcount
  defp found_vowel(<<head::binary-size(1), tail::binary>>, mcount) do
    case is_vowel(head) do
      true  -> found_vowel(tail, mcount)
      false -> found_consonant(tail, mcount + 1)
    end
  end

  defp found_consonant(<<>>, mcount), do: mcount
  defp found_consonant(<<head::binary-size(1), tail::binary>>, mcount) do
    case is_vowel(head, y_is_vowel: true) do
      true  -> found_vowel(tail, mcount)
      false -> found_consonant(tail, mcount)
    end
  end

  @doc """
  Implements *S - the stem ends with "s" (and similarly for other letters).

  Note: this implementation assumes that the second param is a reversed stem
  word!  So we test the 'first' letter in the string...
  
  ## Examples
  
      iex> StemEx.Conditions.ends_with("s", "")
      false

      iex> StemEx.Conditions.ends_with("s", String.reverse("cats"))
      true

      iex> StemEx.Conditions.ends_with("s", String.reverse("catz"))
      false
  """
  def ends_with(_, <<>>)      , do: false
  def ends_with(letter, rstem), do: letter == String.at(rstem, 0)

  @doc """
  Implements *v* - the stem contains a vowel.
  #
  ## Examples
  
      iex> StemEx.Conditions.has_vowel("asdf")
      true

      iex> StemEx.Conditions.has_vowel("zxcv")
      false

      iex> StemEx.Conditions.has_vowel("yz")
      true

      iex> StemEx.Conditions.has_vowel("zy")
      false
  """
  def  has_vowel(rstem), do: has_vowel1(String.reverse(rstem))

  defp has_vowel1(<<>>), do: false
  defp has_vowel1(<<head::binary-size(1), tail::binary>>) do
    is_vowel(head) || has_vowel2(tail)
  end

  defp has_vowel2(<<>>), do: false
  defp has_vowel2(<<head::binary-size(1), tail::binary>>) do
    is_vowel(head, y_is_vowel: true) || has_vowel2(tail)
  end

  @doc """
  Implements *v - the stem ends with a double consonant.

  Note: this implementation assumes that the param is a stem word!  So we test
  the 'first' letters in the string...

  ## Examples
  
      iex> StemEx.Conditions.ends_with_double_cons(String.reverse("catss"))
      true

      iex> StemEx.Conditions.ends_with("s", String.reverse("catez"))
      false

      iex> StemEx.Conditions.ends_with("s", String.reverse("catee"))
      false
  """
  def ends_with_double_cons(<<char::binary-size(1), char::binary-size(1), _::binary>>) do
    is_consonant(char, y_is_vowel: true)
  end
  def ends_with_double_cons(_), do: false

  @doc """
  Implements *o - the stem ends cvc, where the second c is not w, x, or y.

  ## Examples
  
      iex> StemEx.Conditions.ends_with_cvc(String.reverse("asdf"))
      false
  
      iex> StemEx.Conditions.ends_with_cvc(String.reverse("asdod"))
      true

      iex> StemEx.Conditions.ends_with_cvc(String.reverse("asdox"))
      false
  """
  def ends_with_cvc(<<c2::binary-size(1), v::binary-size(1), c1::binary-size(1), _::binary>>) do
    is_consonant(c1) && 
    is_vowel(v, y_is_vowel: true) &&
    (is_consonant(c2) && not Enum.member?(~w(w x y), c2))
  end
  def ends_with_cvc(_), do: false
end

