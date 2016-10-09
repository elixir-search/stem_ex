defmodule StemEx.Steps do
  @moduledoc false

  import StemEx.Conditions

  @doc "Step 1"
  def step1(rword), do: rword |> step1a |> step1b |> step1c

  @doc "Step 1a"
  def step1a("sess" <> rstem), do: "ss" <> rstem
  def step1a("sei"  <> rstem), do: "i"  <> rstem
  def step1a("ss"   <> rstem), do: "ss" <> rstem
  def step1a("s"    <> rstem), do: rstem
  def step1a(rword), do: rword

  @doc "Step 1b"
  def step1b(rword = "dee" <> rstem) do
    if measure(rstem) > 0, do: "ee" <> rstem, else: rword
  end
  def step1b(rword = "de" <> rstem) do
    if has_vowel(rstem), do: step1b2(rstem), else: rword
  end
  def step1b(rword = "gni" <> rstem) do
    if has_vowel(rstem), do: step1b2(rstem), else: rword
  end
  def step1b(rword), do: rword

  @doc "Step 1b2"
  def step1b2("ta" <> rstem), do: "eta" <> rstem
  def step1b2("lb" <> rstem), do: "elb" <> rstem
  def step1b2("zi" <> rstem), do: "ezi" <> rstem
  def step1b2(rword = <<c::binary-size(1), c::binary-size(1), rstem::binary>>) do
    result = ends_with_double_cons(rword) and
    not(ends_with("l", rword) or ends_with("s", rword) or ends_with("z", rword))
    case result do
      true  -> c <> rstem
      false -> rword
    end
  end
  def step1b2(rword) do
    m = measure(rword) == 1
    o = ends_with_cvc(rword)
    cond do
      m and o -> "e" <> rword
      true    -> rword
    end
  end

  @doc "Step 1c"
  def step1c(rword = "y" <> rstem) do
    if has_vowel(rstem), do: "i" <> rstem, else: rword
  end
  def step1c(rword), do: rword

  @doc "Step 2"
  def m_repl(count, rword, rstem, replacement) do
    mcount = measure(rstem)
    if mcount > count, do: replacement <> rstem, else: rword
  end

  step2_transforms = [
    ~w(lanoita eta   ),
    ~w(lanoit  noit  ),
    ~w(icne    ecne  ),
    ~w(icna    ecna  ),
    ~w(rezi    ezi   ),
    ~w(ilb     elb   ),
    ~w(illa    la    ),
    ~w(iltne   tne   ),
    ~w(ile     e     ),
    ~w(ilsuo   suo   ),
    ~w(noitazi ezi   ),
    ~w(noita   eta   ),
    ~w(rota    eta   ),
    ~w(msila   la    ),
    ~w(ssenevi evi   ),
    ~w(ssenluf luf   ),
    ~w(ssensuo suo   ),
    ~w(itila   la    ),
    ~w(itivi   evi   ),
    ~w(itilib  elb   ),
    ~w(igol    gol   ),
  ]

  for [match, replacement] <- step2_transforms do
    @match       match
    @replacement replacement
    def step2(rword = @match <> rstem), do: m_repl(0, rword, rstem, @replacement)
  end

  def step2(rword), do: rword

  @doc "Step 3"

  step3_transforms = [
    ["etaci"    , "ci"    ],
    ["evita"    , ""      ],
    ["ezila"    , "la"    ],
    ["itici"    , "ci"    ],
    ["laci"     , "ci"    ],
    ["luf"      , ""      ],
    ["ssen"     , ""      ],
  ]

  for [match, replacement] <- step3_transforms do
    @match       match
    @replacement replacement
    def step3(rword = @match <> rstem), do: m_repl(0, rword, rstem, @replacement)
  end

  def step3(rword), do: rword

  @doc "Step 4"

  def m_chop(rword, rstem) do
    mcount = measure(rstem)
    if mcount > 1, do: rstem, else: rword
  end

  step4a_chops = ~w(la ecna ecne re ci elba elbi tna tneme tnem tne)

  for match <- step4a_chops do
    @match match
    def step4(rword = @match <> rstem), do: m_chop(rword, rstem)
  end

  def step4(rword = "noi" <> rstem) do
    test = ends_with("s", rstem) || ends_with("t", rstem)
    if test, do: m_chop(rword, rstem), else: rword
  end

  step4b_chops = ~w(uo msi eta iti suo evi ezi)

  for match <- step4b_chops do
    @match match
    def step4(rword = @match <> rstem), do: m_chop(rword, rstem)
  end

  def step4(rword), do: rword

  @doc "Step 5"
  def step5(rword), do: rword |> step5a |> step5b

  def step5a(rword = "e" <> rstem) do
    mcount = measure(rstem)
    o      = not ends_with_cvc(rstem)
    cond do
      mcount > 1       -> rstem
      mcount == 1 && o -> rstem
      true             -> rword
    end
  end
  def step5a(rword), do: rword

  def step5b(rword = "ll" <> rstem) do
    if measure(rword) > 1, do: "l" <> rstem, else: rword
  end
  def step5b(rword), do: rword
end

