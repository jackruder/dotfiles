local function luasnip_setup()
    local ls = require("luasnip")

    ls.config.set_config({
        keep_roots = true,
        link_roots = true,
        exit_roots = true,
        link_children = true,
        enable_autosnippets = true,
    })
    require("luasnip.loaders.from_snipmate").load()
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
    vim.cmd([[
    " Use Tab to expand and jump through snippets
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

    " Use Shift-Tab to jump backwards through snippets
    imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    ]])

    vim.keymap.set({ "i", "s" }, "<C-c>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { silent = true })
end

local function cmp_setup()
    local ls = require("luasnip")
    local lspkind = require("lspkind")
    --vim.o.completeopt = "menuone,noselect,preview"
    local cmp = require("cmp")
    cmp.setup({
        --preselect = cmp.PreselectMode.None,
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                ls.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            completion = cmp.config.window.bordered({}),
            documentation = cmp.config.window.bordered({}),
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-t>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if ls.expandable() then
                        ls.expand()
                    else
                        cmp.confirm({
                            select = true,
                        })
                    end
                else
                    fallback()
                end
            end),
        }),

        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" }, -- For luasnip users.
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lsp_signature_help" },
            { name = "rpncalc" },
            { name = "vimtex" },
            {
                name = "spell",
                option = {
                    keep_all_entries = false,
                    enable_in_context = function()
                        return require("cmp.config.context").in_treesitter_capture("spell")
                    end,
                    preselect_correct_word = true,
                },
            },
            { name = "neorg" },
            { name = "otter" },
            { name = "cmp_r" },
            -- { name = "copilot" },
        }),
        sorting = {
            priority_weight = 2,
            comparators = {
                -- require("copilot_cmp.comparators").prioritize,

                -- Below is the default comparitor list and order for nvim-cmp
                cmp.config.compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },

        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol", -- show only symbol annotations
                maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                symbol_map = { Copilot = "" },

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            }),
        },

    })

    -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "git" },
        }, {
            { name = "buffer" },
        }),
    })
    require("cmp_git").setup()

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
    })

    ls.filetype_extend("markdown", { "tex" })
    ls.filetype_extend("quarto", { "tex" })
    ls.filetype_extend("norg", { "tex" })
end

return {
    {
        'hrsh7th/nvim-cmp',
        config = cmp_setup
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-git' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'f3fora/cmp-spell' },
    { 'micangl/cmp-vimtex' },
    { 'PhilRunninger/cmp-rpncalc' },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = luasnip_setup,
    },
    { 'onsails/lspkind.nvim' },
}
