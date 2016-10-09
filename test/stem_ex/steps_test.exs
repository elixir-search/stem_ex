defmodule StemEx.StepsTest do

  use ExUnit.Case, async: true

  # ----- step1a -----

  functions = %{
    step1:   &StemEx.Steps.step1/1     ,
    step1a:  &StemEx.Steps.step1a/1    ,
    step1b:  &StemEx.Steps.step1b/1    ,
    step1b2: &StemEx.Steps.step1b2/1   ,
    step1c:  &StemEx.Steps.step1c/1    ,
    step2:   &StemEx.Steps.step2/1     ,
    step3:   &StemEx.Steps.step3/1     ,
    step4:   &StemEx.Steps.step4/1     ,
    step5a:  &StemEx.Steps.step5a/1    ,
    step5b:  &StemEx.Steps.step5b/1    ,
  }

  values = [
     [:step1a    , "caresses"       , "caress"         ],
     [:step1a    , "ponies"         , "poni"           ],
     [:step1a    , "ties"           , "ti"             ],
     [:step1a    , "caress"         , "caress"         ],
     [:step1a    , "cats"           , "cat"            ],

     [:step1b    , "feed"           , "feed"           ],
     [:step1b    , "agreed"         , "agree"          ],
     [:step1b    , "plastered"      , "plaster"        ],
     [:step1b    , "bled"           , "bled"           ],
     [:step1b    , "motoring"       , "motor"          ],
     [:step1b    , "sing"           , "sing"           ],

     [:step1b    , "conflated"      , "conflate"       ],
     [:step1b    , "troubled"       , "trouble"        ],
     [:step1b    , "sized"          , "size"           ],
     [:step1b    , "hopping"        , "hop"            ],
     [:step1b    , "tanned"         , "tan"            ],
     [:step1b    , "singing"        , "sing"           ],
     [:step1b    , "falling"        , "fall"           ],
     [:step1b    , "hissing"        , "hiss"           ],
     [:step1b    , "fizzed"         , "fizz"           ],
     [:step1b    , "failing"        , "fail"           ],
     [:step1b    , "filing"         , "file"           ],

     [:step1c     , "happy"          , "happi"         ],
     [:step1c     , "sky"            , "sky"           ],

     [:step1      , "cats"           , "cat"           ],

     [:step2      , "relational"     , "relate"        ],
     [:step2      , "conditional"    , "condition"     ],
     [:step2      , "rational"       , "rational"      ],
     [:step2      , "valenci"        , "valence"       ],
     [:step2      , "hesitanci"      , "hesitance"     ],
     [:step2      , "digitizer"      , "digitize"      ],
     [:step2      , "conformabli"    , "conformable"   ],
     [:step2      , "radicalli"      , "radical"       ],
     [:step2      , "differentli"    , "different"     ],
     [:step2      , "vileli"         , "vile"          ],
     [:step2      , "analogousli"    , "analogous"     ],
     [:step2      , "vietnamization" , "vietnamize"    ],
     [:step2      , "predication"    , "predicate"     ],
     [:step2      , "operator"       , "operate"       ],
     [:step2      , "feudalism"      , "feudal"        ],
     [:step2      , "decisiveness"   , "decisive"      ],
     [:step2      , "hopefulness"    , "hopeful"       ],
     [:step2      , "callousness"    , "callous"       ],
     [:step2      , "formaliti"      , "formal"        ],
     [:step2      , "sensitiviti"    , "sensitive"     ],
     [:step2      , "sensibiliti"    , "sensible"      ],

     [:step3      , "triplicate"     , "triplic"       ],
     [:step3      , "formative"      , "form"          ],
     [:step3      , "formalize"      , "formal"        ],
     [:step3      , "electriciti"    , "electric"      ],
     [:step3      , "electrical"     , "electric"      ],
     [:step3      , "hopeful"        , "hope"          ],
     [:step3      , "goodness"       , "good"          ],

     [:step4      , "revival"        , "reviv"         ],
     [:step4      , "allowance"      , "allow"         ],
     [:step4      , "inference"      , "infer"         ],
     [:step4      , "airliner"       , "airlin"        ],
     [:step4      , "gyroscopic"     , "gyroscop"      ],
     [:step4      , "adjustable"     , "adjust"        ],
     [:step4      , "defensible"     , "defens"        ],
     [:step4      , "irritant"       , "irrit"         ],
     [:step4      , "replacement"    , "replac"        ],
     [:step4      , "adjustment"     , "adjust"        ],
     [:step4      , "dependent"      , "depend"        ],
     [:step4      , "adoption"       , "adopt"         ],
     [:step4      , "homologou"      , "homolog"       ],
     [:step4      , "communism"      , "commun"        ],
     [:step4      , "activate"       , "activ"         ],
     [:step4      , "angulariti"     , "angular"       ],
     [:step4      , "homologous"     , "homolog"       ],
     [:step4      , "effective"      , "effect"        ],
     [:step4      , "bowdlerize"     , "bowdler"       ],

     [:step5a     , "probate"        , "probat"        ],
     [:step5a     , "rate"           , "rate"          ],
     [:step5a     , "cease"          , "ceas"          ],

     [:step5b     , "controll"       , "control"       ],
     [:step5b     , "roll"           , "roll"          ],
]

  for [label, input, output] <- values do
    @label  label
    @input  input
    @output output
    @func   functions[@label]
    test "#{label}: '#{input}' transforms to '#{output}'" do
      result = String.reverse(@func.(String.reverse(@input)))
      assert result == @output
    end
  end
end
