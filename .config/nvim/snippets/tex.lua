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
            snippetType="autosnippet",
            condition=math,
        },
        { t("\\ldots")}
    ),
    s(
        {
            name = "implies",
            trig = "=>",
            snippetType="autosnippet",
            condition=math,
        },
        { t("\\implies")}
    ),
    s(
        {
            name = "implied by",
            trig = "<=",
            snippetType="autosnippet",
            condition=math,
        },
        { t("\\impliedby")}
    ),
    s(
        {
            name = "iff",
            trig = "iff",
            snippetType="autosnippet",
            condition=math,
        },
        { t("\\iff")}
    ),

    s(
        {
            name = "frac",
            trig = "//",
            snippetType="autosnippet",
            condition=math,
        },
        fmta("\\frac{<>}{<>}", {i(1),i(2)})
    ),

    s(
        {
            name = "equals",
            trig = "==",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        fmta("&= <> \\\\", {i(1)})
    ),
    s(
        {
            name = "align continue",
            trig = "&&",
            snippetType="autosnippet",
            condition=math,
        },
        fmta("&<> \\\\", {i(1)})
    ),
    s(
        {
            name = "sqrt",
            trig = "sq",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        fmta("\\sqrt{<>}", {i(1)})
    ),
    s(
        {
            name = "subscript",
            trig = "__",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        fmta("_{<>}", {i(1)})
    ),

    s(
        {
            name = "infinity",
            trig = "ooo",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\infty")}
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
            trig = "UU",
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math,
        },
        { t("\\cup") }
    ),

    s(
        {
            name = "alpha",
            trig = ";a",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\alpha")}
    ),
    s(
        {
            name = "beta",
            trig = ";b",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\beta")}
    ),
    s(
        {
            name = "delta",
            trig = ";d",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\delta")}
    ),
    -- repeat the above three for epsilon, gamma, kappa, ell, nu, rho, sigma, tau, omega
        s(
        {
            name = "epsilon",
            trig = ";e",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\epsilon")}
    ),
    s(
        {
            name = "gamma",
            trig = ";g",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\gamma")}
    ),
    s(
        {
            name = "kappa",
            trig = ";k",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\kappa")}
    ),
    s(
        {
            name = "ell",
            trig = ";l",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\ell")}
    ),
    s(
        {
            name = "nu",
            trig = ";n",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\nu")}
    ),
    s(
        {
            name = "rho",
            trig = ";r",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\rho")}
    ),
    s(
        {
            name = "sigma",
            trig = ";s",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\sigma")}
    ),
    s(
        {
            name = "tau",
            trig = ";t",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\tau")}
    ),
    s(
        {
            name = "omega",
            trig = ";o",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\omega")}
    ),
        s(
        {
            name = "capital alpha",
            trig = ";A",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Alpha")}
    ),
    s(
        {
            name = "capital beta",
            trig = ";B",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Beta")}
    ),
    s(
        {
            name = "capital delta",
            trig = ";D",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Delta")}
    ),
    s(
        {
            name = "capital epsilon",
            trig = ";E",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Epsilon")}
    ),
    s(
        {
            name = "capital gamma",
            trig = ";G",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Gamma")}
    ),
    s(
        {
            name = "capital kappa",
            trig = ";K",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Kappa")}
    ),
    s(
        {
            name = "capital lambda",
            trig = ";L",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Lambda")}
    ),
    s(
        {
            name = "capital nu",
            trig = ";N",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Nu")}
    ),
    s(
        {
            name = "capital rho",
            trig = ";R",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Rho")}
    ),
    s(
        {
            name = "capital sigma",
            trig = ";S",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Sigma")}
    ),
    s(
        {
            name = "capital tau",
            trig = ";T",
            snippetType="autosnippet",
            wordTrig=false,
            condition=math,
        },
        {t("\\Tau")}
    ),


    ms({
        common = {
            name = "capital omega",
            trig = ";O",
            snippetType="autosnippet",
            wordTrig=false,
        },
        {condition=math},
        {filetype="norg"},
        },

        {t("\\Omega")}
    ),
    --[ REGULAR MODE SNIPPETS ]-- 
    s(
        {
            name = "inline math",
            trig = "mk",
            snippetType="autosnippet"
        },
        {t("\\("), i(1), t("\\)"), i(0)}
    ),
    s(
        {
            name = "environment",
            trig="begin",
            snippetType="autosnippet",
            condition=conds.line_begin,
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
              rep(1),  -- this node repeats insert node i(1)
            }
          )
    ),
    s(
        {
            name = "align",
            trig = "ali",
            snippetType="autosnippet",
            condition=conds.line_begin,
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
            snippetType="autosnippet",
            condition=conds.line_begin,
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
            snippetType="autosnippet",
            condition=conds.line_begin,
        },
        fmta(
            [[
            \section{<>}
            <>
            ]],
            { i(1),i(0) }
        )
    ),
    s(
        {
            name = "sub",
            trig = "sub",
            snippetType="autosnippet",
            condition=conds.line_begin,
        },
        fmta(
            [[
            \subsection{<>}
            <>
            ]],
            { i(1),i(0) }
        )
    ),
    s(
        {
            name = "ssub",
            trig = "ssub",
            snippetType="autosnippet",
            condition=conds.line_begin,
        },
        fmta(
            [[
            \subsubsection{<>}
            <>
            ]],
            { i(1),i(0) }
        )
    )
}

