local function lsp_setup()
    local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    )
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    -- MANAGE DEPENDENCIES FOR LSP SERVERS AND LINTERS --
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        pip = {
            upgrade_pip = true,
        },
    })
    require("mason-lspconfig").setup({
        ensure_installed = {
            -- "fish_lsp",
            "ltex",
            "texlab",
            "basedpyright",
            "ruff",
            -- "r_language_server", -- mason no likey
            "lua_ls",
            "efm",
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.supports_method("textDocument/implementation") then
                -- Create a keymap for vim.lsp.buf.implementation
            end
            if client.supports_method("textDocument/formatting") then
                -- Format the current buffer on save
                -- vim.api.nvim_create_autocmd("BufWritePre", {
                --     buffer = args.buf,
                --     callback = function()
                --         vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                --     end,
                -- })
            end
        end,
    })

    local lspconfig = require("lspconfig")

    require("lsp-format").setup({})

    local common_attach = function(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>od",
            "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>",
            { noremap = true, silent = true }
        )
    end
    vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

    -- fish
    -- lspconfig.fish_lsp.setup({ capabilities = capabilities, on_attach = common_attach })

    -- grammar
    lspconfig.ltex.setup({ capabilities = capabilities, on_attach = common_attach })

    -- latex
    lspconfig.texlab.setup({ capabilities = capabilities, on_attach = common_attach })

    lspconfig.basedpyright.setup({
        capabilities = capabilities,
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                disableTaggedHints = false,
                analysis = {
                    typeCheckingMode = "standard",
                    useLibraryCodeForTypes = true, -- Analyze library code for type information
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                    diagnosticSeverityOverrides = {
                        reportIgnoreCommentWithoutRule = true,
                    },
                },
            },
        },
    })

    lspconfig.ruff.setup({
        on_attach = function(client, bufnr)
            -- common_on_attach_handler(client, bufnr)
            client.server_capabilities.disableHoverProvider = false
            require("lsp-format").on_attach(client, bufnr)
        end,
        init_options = {
            settings = {
                -- Any extra CLI arguments for `ruff` go here.
                args = {},
            },
        },
    })

    -- rust
    lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = common_attach,
        root_dir = lspconfig.util.root_pattern("Cargo.toml"),
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                },
                add_return_type = {
                    enable = true,
                },
                inlayHints = {
                    enable = true,
                    showParameterNames = true,
                    parameterHintsPrefix = "<- ",
                    otherHintsPrefix = "=> ",
                },
            },
        },
    })

    -- r
    lspconfig.r_language_server.setup({
        capabilities = capabilities,
        on_attach = common_attach,
    })

    -- LUA
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
        on_attach = common_attach,
    })

    -- FORMATTING AND LINTING --
    -- Register linters and formatters per language

    -- misc lint --
    local vale = require("efmls-configs.linters.vale")
    -- local languagetool = require('efmls-configs.linters.languagetool')

    -- fish --
    local fish = require("efmls-configs.linters.fish")
    local fish_indent = require("efmls-configs.formatters.fish_indent")

    --git lint--
    local gitlint = require("efmls-configs.linters.gitlint")

    -- lua --
    local luacheck = require("efmls-configs.linters.luacheck")
    local stylua = require("efmls-configs.formatters.stylua")

    -- markdown --
    local markdownlint = require("efmls-configs.linters.markdownlint")

    -- rust --
    local rustfmt = require("efmls-configs.formatters.rustfmt")

    -- latex --

    -- yaml --
    local yamllint = require("efmls-configs.linters.yamllint")
    local prettier = require("efmls-configs.formatters.prettier")

    local languages = require("efmls-configs.defaults").languages()
    languages = vim.tbl_extend("force", languages, {
        fish = { fish, fish_indent },
        lua = { luacheck, stylua },
        gitcommit = { gitlint },
        markdown = { markdownlint },
        -- python = { ruff_l, ruff_f }, -- use ruff directly from lsp
        rust = { rustfmt },
        -- latex = { }, -- use texlab instead, not compatib
        yaml = { yamllint, prettier },
    })
    -- Or use the defaults provided by this plugin
    -- check doc/SUPPORTED_LIST.md for the supported languages
    --
    -- local languages = require('efmls-configs.defaults').languages()

    local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = { ".git/" },
            languages = languages,
        },
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
        },
    }

    lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {
        on_attach = common_attach,
        capabilities = capabilities,
    }))
end

--- RUST ---
-- vim.g.rustaceanvim = {
-- 	-- Plugin configuration
-- 	tools = {},
-- 	-- LSP configuration
-- 	server = {
-- 		on_attach = function(client, bufnr)
-- 			common_attach(client, bufnr)
-- 			if client.server_capabilities.inlayHintProvider then
-- 				vim.lsp.inlay_hint.enable(true)
-- 			end
-- 		end,
-- 		capabilities = capabilities,
-- 		default_settings = {
-- 			-- rust-analyzer language server configuration
-- 			["rust-analyzer"] = {
-- 				cargo = {
-- 					all_features = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- 	-- DAP configuration
-- 	dap = {},
-- }
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { "BufNewFile", "BufRead", "BufEnter" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts_extend = { "ensure_installed" },
        opts = {
            -- Install parsers synchronously (only applied to `ensure_installed`)
            ensure_installed = { "lua", "python", "rust", "c" },
            ignore_install = { "latex", "bibtex" },
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            -- List of parsers to ignore installing (or "all")
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        config = lsp_setup,
        dependencies = { "nvim-treesitter/nvim-treesitter", "mason-lspconfig.nvim", "mason.nvim" },
    },
    {
        'williamboman/mason.nvim',
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            pip = {
                upgrade_pip = true,
            },
        }
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                "fish_lsp", "ltex", "texlab", "basedpyright", "ruff", "lua_ls", "efm" }
        }
    },
    { 'creativenull/efmls-configs-nvim', version = 'v1.x.x', dependencies = { 'neovim/nvim-lspconfig' } },
    { 'lukas-reineke/lsp-format.nvim' },
    { 'mfussenegger/nvim-dap' },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
    {
        'creativenull/efmls-configs-nvim',
        version = 'v1.x.x', -- version is optional, but recommended
        dependencies = { 'neovim/nvim-lspconfig' },
    },
    { 'lukas-reineke/lsp-format.nvim' },
    { 'mfussenegger/nvim-dap' },
    {
        "lervag/vimtex", -- TODO: learn motions
        lazy = false,    -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end
    }
}
