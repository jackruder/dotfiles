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
            trig = "NN",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\bigcap_{"), i(1), t("}^{\\infty}"), i(0) }
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
    -- repeat the above three for epsilon, gamma, kappa, ell, nu, rho, sigma, tau, omega
    s(
        {
            name = "epsilon",
            trig = ";e",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("ε") }
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
            name = "capital nu",
            trig = ";N",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("Ν") }
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
        { t("\\("), i(1), t("\\)"), i(0) }
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

}
