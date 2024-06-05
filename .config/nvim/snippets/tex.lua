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
    )
}

