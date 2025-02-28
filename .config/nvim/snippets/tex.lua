local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key



local function math()
    return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end


return { -- can also return two lists, one list of reg one auto
    -- [[ MATH MODE SNIPPETS ]] --
    s(
        {
            name = "ldots", -- TODO change so
            trig = "...",
            snippetType = "autosnippet",
            condition = math,
        },
        { t("\\ldots") }
    ),
    s(
        {
            name = "implies",
            trig = "=>",
            snippetType = "autosnippet",
            condition = math,
        },
        { t("\\implies") }
    ),
    s(
        {
            name = "implied by",
            trig = "<=",
            snippetType = "autosnippet",
            condition = math,
        },
        { t("\\impliedby") }
    ),
    s(
        {
            name = "iff",
            trig = "iff",
            snippetType = "autosnippet",
            condition = math,
        },
        { t("\\iff") }
    ),

    s(
        {
            name = "frac",
            trig = "//",
            snippetType = "autosnippet",
            condition = math,
        },
        fmta("\\frac{<>}{<>}", { i(1), i(2) })
    ),

    s(
        {
            name = "equals",
            trig = "==",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        fmta("&= <> \\\\", { i(1) })
    ),
    s(
        {
            name = "align continue",
            trig = "&&",
            snippetType = "autosnippet",
            condition = math,
        },
        fmta("&<> \\\\", { i(1) })
    ),
    s(
        {
            name = "sqrt",
            trig = "sq",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        fmta("\\sqrt{<>}", { i(1) })
    ),
    s(
        {
            name = "subscript",
            trig = "__",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        fmta("_{<>}", { i(1) })
    ),

    s(
        {
            name = "superscript",
            trig = "^^",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        fmta("^{<>}", { i(1) })
    ),

    s(
        {
            name = "subsup",
            trig = "_^",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        fmta("_{<>}^{<>}", { i(1), i(2) })
    ),

    s(
        {
            name = "sum",
            trig = "sum",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        t("∑")
    ),

    s(
        {
            name = "product",
            trig = "prod",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        t("∏")
    ),

    s(
        {
            name = "sim",
            trig = "~",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        t("∼")
    ),


    s(
        {
            name = "infinity",
            trig = "ooo",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∞") }
    ),

    s(
        {
            name = "times",
            trig = "xx",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\times") }
    ),

    s(
        {
            name = "cdot",
            trig = "**",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\cdot") }
    ),

    s(
        {
            name = "union",
            trig = "uu",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\cup_{"), i(1), t("}^{\\infty}"), i(0) }
    ),
    s(
        {
            name = "infinite union",
            trig = "UU",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\bigcup_{"), i(1), t("}^{\\infty}"), i(0) }
    ),

    s(
        {
            name = "intersection",
            trig = "nn",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\cap_{"), i(1), t("}^{\\infty}"), i(0) }
    ),

    s(
        {
            name = "lr parens",
            trig = "lr(",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\left("), i(1), t("\\right)"), i(0) }
    ),

    s(
        {
            name = "lr brackets",
            trig = "lr[",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\left["), i(1), t("\\right]"), i(0) }
    ),

    s(
        {
            name = "lr braces",
            trig = "lr{",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\left\\{"), i(1), t("\\right\\}"), i(0) }
    ),

    s(
        {
            name = "infinite intersection",
            trig = "nn",
            snippettype = "autosnippet",
            wordtrig = false,
            condition = math,
        },
        { t("\\bigcap_{"), i(1), t("}^{\\infty}"), i(0) }
    ),

    s({
            trig = "(.)%.%,", -- Pattern for ".,"
            name = "mathbf symbol (.,)",
            snippetType = "autosnippet",
            wordTrig = false,
            trigEngine = "pattern",
            condition = math,
        },
        {
            t("\\mathbf{"),
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("}"),
            -- Optionally, remove the trailing punctuation by not including it
            i(0),
        }
    ),

    s(
        {
            name = "bold a",
            trig = "a,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐚"),
        }

    ),

    s(
        {
            name = "bold b",
            trig = "b,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐛"),
        }

    ),

    s(
        {
            name = "bold c",
            trig = "c,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐜"),
        }

    ),

    s(
        {
            name = "bold d",
            trig = "d,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐝"),
        }

    ),

    s(
        {
            name = "bold e",
            trig = "e,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐞"),
        }

    ),

    s(
        {
            name = "bold f",
            trig = "f,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐟"),
        }

    ),

    s(
        {
            name = "bold g",
            trig = "g,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐠"),
        }

    ),

    s(
        {
            name = "bold h",
            trig = "h,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐡"),
        }

    ),
    s(
        {
            name = "bold i",
            trig = "i,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐢"),
        }

    ),
    s(
        {
            name = "bold j",
            trig = "j,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐣"),
        }

    ),
    s(
        {
            name = "bold k",
            trig = "k,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐤"),
        }

    ),

    s(
        {
            name = "bold l",
            trig = "l,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐥"),
        }

    ),

    s(
        {
            name = "bold m",
            trig = "m,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐦"),
        }
    ),

    s(
        {
            name = "bold n",
            trig = "n,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐧"),
        }
    ),

    s(
        {
            name = "bold o",
            trig = "o,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐨"),
        }

    ),

    s(
        {
            name = "bold p",
            trig = "p,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐩"),
        }

    ),

    s(
        {
            name = "bold q",
            trig = "q,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐪"),
        }

    ),

    s(
        {
            name = "bold r",
            trig = "r,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐫"),
        }

    ),

    s(
        {
            name = "bold s",
            trig = "s,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐬"),
        }

    ),

    s(
        {
            name = "bold t",
            trig = "t,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐭"),
        }

    ),

    s(
        {
            name = "bold u",
            trig = "u,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐮"),
        }

    ),

    s(
        {
            name = "bold v",
            trig = "v,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐯"),
        }

    ),

    s(
        {
            name = "bold w",
            trig = "w,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐰"),
        }

    ),

    s(
        {
            name = "bold x",
            trig = "x,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐱"),
        }

    ),

    s(
        {
            name = "bold y",
            trig = "y,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐲"),
        }

    ),

    s(
        {
            name = "bold z",
            trig = "z,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐳"),
        }

    ),

    -- now all the capital letters
    s(
        {
            name = "bold A",
            trig = "A,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐀"),
        }

    ),

    s(
        {
            name = "bold B",
            trig = "B,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐁"),
        }

    ),

    s(
        {
            name = "bold C",
            trig = "C,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐂"),
        }

    ),

    s(
        {
            name = "bold D",
            trig = "D,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐃"),
        }

    ),

    s(
        {
            name = "bold E",
            trig = "E,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐄"),
        }

    ),

    s(
        {
            name = "bold F",
            trig = "F,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐅"),
        }

    ),

    s(
        {
            name = "bold G",
            trig = "G,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐆"),
        }

    ),

    s(
        {
            name = "bold H",
            trig = "H,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐇"),
        }

    ),

    s(
        {
            name = "bold I",
            trig = "I,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐈"),
        }

    ),

    s(
        {
            name = "bold J",
            trig = "J,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐉"),
        }

    ),

    s(
        {
            name = "bold K",
            trig = "K,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐊"),
        }

    ),

    s(
        {
            name = "bold L",
            trig = "L,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐋"),
        }

    ),

    s(
        {
            name = "bold M",
            trig = "M,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐌"),
        }

    ),

    s(
        {
            name = "bold N",
            trig = "N,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐍"),
        }

    ),

    s(
        {
            name = "bold O",
            trig = "O,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐎"),
        }

    ),

    s(
        {
            name = "bold P",
            trig = "P,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐏"),
        }

    ),

    s(
        {
            name = "bold Q",
            trig = "Q,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐐"),
        }

    ),

    s(
        {
            name = "bold R",
            trig = "R,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐑"),
        }

    ),

    s(
        {
            name = "bold S",
            trig = "S,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐒"),
        }

    ),

    s(
        {
            name = "bold T",
            trig = "T,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐓"),
        }

    ),

    s(
        {
            name = "bold U",
            trig = "U,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐔"),
        }

    ),

    s(
        {
            name = "bold V",
            trig = "V,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐕"),
        }

    ),

    s(
        {
            name = "bold W",
            trig = "W,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐖"),
        }

    ),

    s(
        {
            name = "bold X",
            trig = "X,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐗"),
        }

    ),

    s(
        {
            name = "bold Y",
            trig = "Y,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐘"),
        }

    ),

    s(
        {
            name = "bold Z",
            trig = "Z,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝐙"),
        }

    ),

    s(
        {
            name = "bold alpha",
            trig = "α,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛂"),
        }

    ),

    s(
        {
            name = "bold beta",
            trig = "β,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛃"),
        }

    ),

    s(
        {
            name = "bold gamma",
            trig = "γ,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛄"),
        }

    ),

    s(
        {
            name = "bold delta",
            trig = "δ,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛅"),
        }

    ),

    s(
        {
            name = "bold epsilon",
            trig = "𝜖,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛜"),
        }

    ),

    s(
        {
            name = "bold mu",
            trig = "μ,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛍"),
        }

    ),

    s(
        {
            name = "bold eta",
            trig = "η,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝜂"),
        }

    ),

    s(
        {
            name = "bold sigma",
            trig = "σ,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛔"),
        }
    ),

    s(
        {
            name = "bold theta",
            trig = "θ,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛉"),
        }

    ),

    s(
        {
            name = "bold omega",
            trig = "ω,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝛚"),
        }

    ),

    s(
        {
            name = "bold 0",
            trig = "0,.",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        {
            t("𝟎"),
        }
    ),

    s(
        {
            name = "alpha",
            trig = ";a",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("α") }
    ),
    s(
        {
            name = "beta",
            trig = ";b",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("β") }
    ),
    s(
        {
            name = "delta",
            trig = ";d",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("δ") }
    ),

    s(
        {
            name = "epsilon",
            trig = ";e",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝜖") }
    ),

    s(
        {
            name = "varepsilon",
            trig = ";ve",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ε") }
    ),

    s(
        {
            name = "theta",
            trig = ";h",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("θ") }
    ),

    s(
        {
            name = "gamma",
            trig = ";g",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("γ") }
    ),
    s(
        {
            name = "kappa",
            trig = ";k",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("κ") }
    ),
    s(
        {
            name = "lambda",
            trig = ";l",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("λ") }
    ),
    s(
        {
            name = "mu",
            trig = ";m",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("μ") }
    ),
    s(
        {
            name = "nu",
            trig = ";n",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ν") }
    ),
    s(
        {
            name = "omicron",
            trig = ";o",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ο") }
    ),

    s(
        {
            name = "pi",
            trig = ";p",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("π") }
    ),

    s(
        {
            name = "phi",
            trig = ";q",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("φ") }
    ),

    s(
        {
            name = "rho",
            trig = ";r",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ρ") }
    ),
    s(
        {
            name = "sigma",
            trig = ";s",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("σ") }
    ),
    s(
        {
            name = "tau",
            trig = ";t",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("τ") }
    ),

    s(
        {
            name = "omega",
            trig = ";w",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ω") }
    ),

    s(
        {
            name = "chi",
            trig = ";x",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("χ") }
    ),
    s(
        {
            name = "psi",
            trig = ";y",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ψ") }
    ),

    s(
        {
            name = "zeta",
            trig = ";z",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ζ") }
    ),
    s(
        {
            name = "capital alpha",
            trig = ";A",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Α") }
    ),
    s(
        {
            name = "capital beta",
            trig = ";B",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Β") }
    ),
    s(
        {
            name = "capital delta",
            trig = ";D",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Δ") }
    ),
    s(
        {
            name = "capital epsilon",
            trig = ";E",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Ε") }
    ),
    s(
        {
            name = "capital gamma",
            trig = ";G",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Γ") }
    ),
    s(
        {
            name = "capital kappa",
            trig = ";K",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Κ") }
    ),
    s(
        {
            name = "capital lambda",
            trig = ";L",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Λ") }
    ),

    s(
        {
            name = "capital mu",
            trig = ";M",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Μ") }
    ),
    s(
        {
            name = "nabla",
            trig = ";N",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∇") }
    ),
    s(
        {
            name = "capital rho",
            trig = ";R",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Ρ") }
    ),
    s(
        {
            name = "capital sigma",
            trig = ";S",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Σ") }
    ),
    s(
        {
            name = "capital tau",
            trig = ";T",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Τ") }
    ),
    ms({
            common = {
                name = "capital omega",
                trig = ";W",
                snippetType = "autosnippet",
                wordTrig = false,
            },
            { condition = math },
            { filetype = "norg" },
        },

        { t("Ω") }
    ),
    s(
        {
            name = "real numbers",
            trig = ":R",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℝ") }
    ),

    s(
        {
            name = "natural numbers",
            trig = ":N",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℕ") }
    ),

    s(
        {
            name = "rational numbers",
            trig = ":Q",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℚ") }
    ),

    s(
        {
            name = "complex numbers",
            trig = ":C",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℂ") }
    ),

    s(
        {
            name = "integers",
            trig = ":Z",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℤ") }
    ),

    s(
        {
            name = "empty set",
            trig = ":0",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∅") }
    ),

    s(
        {
            name = "partial",
            trig = "partial",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∂") }
    ),

    s(
        {
            name = "forall",
            trig = "forall",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∀") }
    ),

    s(
        {
            name = "exists",
            trig = "exists",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∃") }
    ),

    s(
        {
            name = "integral",
            trig = "int",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∫") }
    ),

    s(
        {
            name = "to",
            trig = "to",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("→") }
    ),

    s(
        {
            name = "elem",
            trig = "elem",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∈") }
    ),

    s(
        {
            name = "not in",
            trig = "notin",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("∉") }
    ),

    s(
        {
            name = "subset",
            trig = "subset",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("⊂") }

    ),

    s(
        {
            name = "not subset",
            trig = "notsubset",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("⊄") }
    ),

    s(
        {
            name = "geq",
            trig = ">=",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("≥") }
    ),

    s(
        {
            name = "leq",
            trig = "<=",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("≤") }
    ),

    s(
        {
            name = "Script A",
            trig = ":a",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒜") }
    ),

    s(
        {
            name = "Script B",
            trig = ":b",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℬ") }
    ),

    s(
        {
            name = "Script C",
            trig = ":c",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒞") }
    ),

    s(
        {
            name = "Script D",
            trig = ":d",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒟") }
    ),

    s(
        {
            name = "Script E",
            trig = ":e",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℰ") }
    ),

    s(
        {
            name = "Script F",
            trig = ":f",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℱ") }
    ),

    s(
        {
            name = "Script G",
            trig = ":g",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒢") }
    ),

    s(
        {
            name = "Script H",
            trig = ":h",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℋ") }
    ),

    s(
        {
            name = "Script I",
            trig = ":i",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℐ") }
    ),

    s(
        {
            name = "Script J",
            trig = ":j",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒥") }
    ),

    s(
        {
            name = "Script K",
            trig = ":k",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒦") }
    ),

    s(
        {
            name = "Script L",
            trig = ":l",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℒ") }
    ),

    s(
        {
            name = "Script M",
            trig = ":m",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℳ") }
    ),

    s(
        {
            name = "Script N",
            trig = ":n",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒩") }
    ),

    s(
        {
            name = "Script O",
            trig = ":o",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒪") }
    ),

    s(
        {
            name = "Script P",
            trig = ":p",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒫") }
    ),

    s(
        {
            name = "Script Q",
            trig = ":q",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒬") }
    ),

    s(
        {
            name = "Script R",
            trig = ":r",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ℛ") }
    ),

    s(
        {
            name = "Script S",
            trig = ":s",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒮") }
    ),

    s(
        {
            name = "Script T",
            trig = ":t",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒯") }
    ),

    s(
        {
            name = "Script U",
            trig = ":u",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒰") }
    ),

    s(
        {
            name = "Script V",
            trig = ":v",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒱") }
    ),

    s(
        {
            name = "Script W",
            trig = ":w",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒲") }
    ),

    s(
        {
            name = "Script X",
            trig = ":x",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒳") }
    ),

    s(
        {
            name = "Script Y",
            trig = ":y",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒴") }
    ),

    s(
        {
            name = "Script Z",
            trig = ":z",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("𝒵") }
    ),

    --[ REGULAR MODE SNIPPETS ]--
    s(
        {
            name = "inline math",
            trig = "mk",
            snippetType = "autosnippet"
        },
        { t("\\( "), i(1), t(" \\)"), i(0) }
    ),
    s(
        {
            name = "environment",
            trig = "begin",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
              \begin{<>}
                  <>
              \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1), -- this node repeats insert node i(1)
            }
        )
    ),
    s(
        {
            name = "align",
            trig = "ali",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
            \begin{align*}
                <>
            \end{align*}
            ]],
            { i(1) }
        )
    ),
    s(
        {
            name = "eq",
            trig = "eq",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
            \begin{equation*}
                <>
            \end{equation*}
            ]],
            { i(1) }
        )
    ),
    s(
        {
            name = "sec",
            trig = "sec",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
            \section{<>}
            <>
            ]],
            { i(1), i(0) }
        )
    ),
    s(
        {
            name = "sub",
            trig = "sub",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
            \subsection{<>}
            <>
            ]],
            { i(1), i(0) }
        )
    ),
    s(
        {
            name = "ssub",
            trig = "ssub",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
            \subsubsection{<>}
            <>
            ]],
            { i(1), i(0) }
        )
    ),

    s(
        {
            name = "template",
            trig = "template",
            snippetType = "autosnippet",
            condition = conds.line_begin,
        },
        fmta(
            [[
            %! TeX program = lualatex

            \documentclass[12pt, a4paper]{article}
            \usepackage[margin=0.5in]{geometry}
            \usepackage{unicode-math}
            \setmainfont{STIXTwoText}
            \setmathfont{STIXTwoMath}
            \usepackage{amsmath}

            \title{<>}
            \author{Jack Ruder}

            \begin{document}
            \maketitle
            <>
            \end{document}
            ]],
            { i(1), i(0) }
        )
    ),

    s({ trig = "summary", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \papersummary
            {<>} % Title
            {<>} % Citation
            {<>} % Abstract
            {%
              <>
            } % Contributions
            {%
              <>
            } % Informal Notes
            {%
              <>
            } % Discussion and Critique
            ]], {
                i(1, "Title"),
                i(2, "Citation"),
                i(3, "Abstract"),
                i(4, "Contributions"),
                i(5, "Informal Notes"),
                i(6, "Discussion and Critique")
            })
    ),

    s({ trig = "thm", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{theorem}{<>}{<>}
            <>
            \end{theorem}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),

    -- Lemma snippet: \begin{lemma}{Title}{Label} ... \end{lemma}
    s({ trig = "lem", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{lemma}{<>}{<>}
            <>
            \end{lemma}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),

    -- Corollary snippet: \begin{corollary}{Title}{Label} ... \end{corollary}
    s({ trig = "cor", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{corollary}{<>}{<>}
            <>
            \end{corollary}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),

    -- Definition snippet: \begin{definition}{Title}{Label} ... \end{definition}
    s({ trig = "def", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{definition}{<>}{<>}
            <>
            \end{definition}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),

    -- Note snippet: \begin{note}{Title}{Label} ... \end{note}
    s({ trig = "note", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{note}{<>}{<>}
            <>
            \end{note}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),

    -- Example snippet: \begin{example}{Title}{Label} ... \end{example}
    s({ trig = "exa", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{example}{<>}{<>}
            <>
            \end{example}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),

    -- Objective snippet: \begin{objective}{Title}{Label} ... \end{objective}
    s({ trig = "obj", snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
            \begin{objective}{<>}{<>}
            <>
            \end{objective}
            ]],
            { i(1, "Title"), i(2, "Label"), i(0) })
    ),


}
