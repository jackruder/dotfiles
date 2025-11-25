-- lua/plugins/lsp.lua

local function lsp_setup()
    -- Capabilities (with cmp if present)
    local base_caps = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    local capabilities = ok_cmp and vim.tbl_deep_extend("force", base_caps, cmp.default_capabilities()) or base_caps
    capabilities.textDocument = capabilities.textDocument or {}
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

    -- MANAGE DEPENDENCIES FOR LSP SERVERS AND LINTERS --
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        pip = { upgrade_pip = true },
    })
    require("mason-lspconfig").setup({
        ensure_installed = {
            "ltex_plus",
            "texlab",
            "basedpyright",
            "ruff",
            -- "r_language_server",
            "lua_ls",
            "efm",
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name then
                vim.notify(("LSP attached: %s"):format(client.name), vim.log.levels.INFO)
            end
            if client and client.supports_method("textDocument/formatting") then
                -- Example: format on save (disabled by default)
                -- vim.api.nvim_create_autocmd("BufWritePre", {
                --   buffer = args.buf,
                --   callback = function()
                --     vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                --   end,
                -- })
            end
        end,
    })

    -- Only use util helpers from lspconfig (no deprecated setup framework)
    local util = require("lspconfig.util")

    require("lsp-format").setup({
        order = {
            tex = { "efm" },
            plaintex = { "efm" },
            -- optional: avoid accidental double-format elsewhere
            -- lua = { "efm" },   -- if you want stylua via efm instead of lua_ls
            -- rust = { "efm" },  -- if you want rustfmt via efm instead of rust_analyzer
        },
    })

    local function common_attach(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)
        vim.keymap.set("n", "<leader>od", function()
            vim.diagnostic.open_float(0, { scope = "line" })
        end, { buffer = bufnr, silent = true })
    end

    vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])


    -- Compute TeX project root (supports both return and callback styles)
    local function tex_root_compute(bufnr_or_name)
        local fname
        if type(bufnr_or_name) == "number" then
            fname = vim.api.nvim_buf_get_name(bufnr_or_name)
        elseif type(bufnr_or_name) == "string" and bufnr_or_name ~= "" then
            fname = bufnr_or_name
        else
            fname = vim.api.nvim_buf_get_name(0)
        end

        -- Ask VimTeX (best with \subfile workflows)
        local ok_vimtex, doc = pcall(function()
            return vim.fn["vimtex#state#document"](vim.api.nvim_get_current_buf())
        end)
        if ok_vimtex and doc and type(doc.root) == "string" and doc.root ~= "" then
            return doc.root
        end

        -- Markers: prefer explicit; avoid latexmkrc so $HOME never becomes root
        local start = (fname ~= "" and vim.fs.dirname(fname)) or vim.fn.getcwd()
        local markers = { "texlabroot.json", "main.tex", ".git" }
        local found = vim.fs.find(markers, { path = start, upward = true })[1]
        if type(found) == "string" and found ~= "" then
            return vim.fs.dirname(found)
        end
        return start
    end

    -- New API can pass a callback; support both styles
    local function tex_root(arg1, on_dir)
        local dir = tex_root_compute(arg1)
        if type(on_dir) == "function" then
            return on_dir(dir)
        end
        return dir
    end

    -- Resolve Mason bin paths explicitly to avoid PATH timing issues
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

    -- grammar: ltex
    vim.lsp.config("ltex_plus", {
        cmd = { mason_bin .. "ltex-ls-plus" },
        filetypes = { "bib", "gitcommit", "markdown", "org", "norg", "plaintex", "rnoweb", "tex", "text" },
        root_dir = tex_root,
        single_file_support = true,
        capabilities = capabilities,
        on_attach = common_attach,
    })

    -- latex: texlab
    vim.lsp.config("texlab", {
        cmd = { mason_bin .. "texlab" },
        filetypes = { "tex", "plaintex", "bib" },
        root_dir = tex_root,
        single_file_support = true,
        capabilities = capabilities,
        -- custom attach to let EFM format
        on_attach = 
            function(client, bufnr)
                -- Disable texlab formatting in favor of efm
                -- Only efm should format TeX
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                common_attach(client, bufnr)
            end,
        on_new_config = function(new_config, root)
            new_config.settings = new_config.settings or {}
            new_config.settings.texlab = new_config.settings.texlab or {}
            new_config.settings.texlab.rootDirectory = root
        end,
    })

    -- Ensure servers are enabled when TeX buffers open
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex", "bib" },
        callback = function()
            vim.lsp.enable("texlab")
            vim.lsp.enable("ltex_plus")
            -- Debug notify to confirm the autocmd fires
            vim.notify("Enabled texlab/ltex for TeX buffer", vim.log.levels.DEBUG)
        end,
    })

    -- Python: basedpyright
    vim.lsp.config("basedpyright", {
        cmd = {mason_bin .. "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git",
            "ruff.toml",
            "pixi.toml"
        },
        capabilities = capabilities,
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                disableTaggedHints = false,
                analysis = {
                    typeCheckingMode = "standard",
                    useLibraryCodeForTypes = true,
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                    diagnosticSeverityOverrides = {
                        reportIgnoreCommentWithoutRule = true,
                        reportLineTooLong = "none",

                    },
                    diagnosticMode = "workspace",
                    extraPaths = {"src"},
                    logLevel = "Information",
                },
            },
        },
    })

    -- Python: ruff
    vim.lsp.config("ruff", {
        cmd = { mason_bin .. "ruff", "server"},
        filetypes = { "python" },
        root_markers = {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git",
            "ruff.toml",
            "pixi.toml"
        },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
            -- client.server_capabilities.hoverProvider = false -- if you prefer BasedPyright hovers
            common_attach(client, bufnr)
        end,
        init_options = { settings = { args = {} } },
    })


    -- rust
    vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_dir = util.root_pattern("Cargo.toml"),
        capabilities = capabilities,
        on_attach = common_attach,
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                add_return_type = { enable = true },
                inlayHints = {
                    enable = true,
                    showParameterNames = true,
                    parameterHintsPrefix = "<- ",
                    otherHintsPrefix = "=> ",
                },
            },
        },
        single_file_support = true,
    })

    -- r
    vim.lsp.config("r_language_server", {
        cmd = { "R", "--slave", "-e", "languageserver::run()" },
        filetypes = { "r", "rnoweb", "rmd", "quarto", "qmd" },
        root_dir = util.root_pattern(".git", ".Rproj.user", "*.Rproj"),
        capabilities = capabilities,
        on_attach = common_attach,
        settings = {
            r = {
                lsp = {
                    rich_documentation = false,
                },
            },
        },
    })

    -- LUA
    vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_dir = util.root_pattern(".git", ".luarc.json", ".luacheckrc", "stylua.toml"),
        capabilities = capabilities,
        on_attach = common_attach,
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
            },
        },
        single_file_support = true,
    })

    -- FORMATTING AND LINTING --
    -- Register linters and formatters per language
    local vale = require("efmls-configs.linters.vale")
    local chktex = require("efmls-configs.linters.chktex")
    local latexindent = {
        -- if efm's cwd is TeX project root, this finds localSettings.yaml there
        formatCommand = "latexindent -m -rv -l defaultSettings.yaml -",
        formatStdin = true,
    }

    local fish = require("efmls-configs.linters.fish")
    local fish_indent = require("efmls-configs.formatters.fish_indent")

    local gitlint = require("efmls-configs.linters.gitlint")

    local luacheck = require("efmls-configs.linters.luacheck")
    local stylua = require("efmls-configs.formatters.stylua")

    local markdownlint = require("efmls-configs.linters.markdownlint")

    local rustfmt = require("efmls-configs.formatters.rustfmt")

    local yamllint = require("efmls-configs.linters.yamllint")
    local prettier = require("efmls-configs.formatters.prettier")

    local languages = require("efmls-configs.defaults").languages()
    languages = vim.tbl_extend("force", languages, {
        fish = { fish, fish_indent },
        lua = { luacheck, stylua },
        gitcommit = { gitlint },
        markdown = { markdownlint },
        python = {}, -- use ruff directly from lsp
        rust = { rustfmt },
        tex = {chktex, latexindent, vale},
        plaintex = {chktex, latexindent, vale},
        bib = {},
        yaml = { yamllint, prettier },
    })

    local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = { ".git/", "main.tex"},
            languages = languages,
        },
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
        },
    }

    vim.lsp.config("efm", {
        cmd = { "efm-langserver" },
        filetypes = efmls_config.filetypes,
        root_dir = tex_root, -- HACK: this defaults to .git when no markers found; better for TeX
        on_attach = common_attach,
        capabilities = capabilities,
        init_options = efmls_config.init_options,
        settings = efmls_config.settings,
    }) end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufNewFile", "BufRead", "BufEnter" },
        lazy = vim.fn.argc(-1) == 0,
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp early if needed
            -- require("lazy.core.loader").add_to_rtp(plugin)
            -- require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "lua", "python", "rust", "c", "markdown", "markdown_inline", "yaml", "rnoweb", "r", "csv",
                "latex", "bibtex",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                -- Keep VimTeX for LaTeX highlighting; TS parser is still present for rainbow-delimiters
                disable = { "latex", "tex", "plaintex", "bib" },
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
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        config = lsp_setup,
        dependencies = { "nvim-treesitter/nvim-treesitter", "mason-lspconfig.nvim", "mason.nvim" },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            pip = { upgrade_pip = true },
        },
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "creativenull/efmls-configs-nvim", version = "v1.x.x", dependencies = { "neovim/nvim-lspconfig" } },
    { "lukas-reineke/lsp-format.nvim" },
    { "mfussenegger/nvim-dap" },
    -- {
    --     "HiPhish/rainbow-delimiters.nvim",
    --     event = { "BufReadPost", "BufNewFile" },
    --     dependencies = { "nvim-treesitter/nvim-treesitter" },
    --     config = function()
    --         local rd = require("rainbow-delimiters")
    --         vim.g.rainbow_delimiters = {
    --             strategy = {
    --                 [""] = rd.strategy["local"],
    --                 -- latex = rd.strategy['global'], -- optional for very large files
    --             },
    --             highlight = {
    --                 "RainbowDelimiterRed",
    --                 "RainbowDelimiterYellow",
    --                 "RainbowDelimiterBlue",
    --                 "RainbowDelimiterOrange",
    --                 "RainbowDelimiterGreen",
    --                 "RainbowDelimiterViolet",
    --                 "RainbowDelimiterCyan",
    --             },
    --         }
    --     end,
    -- },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_subfile_start_local = 1
            vim.g.vimtex_indent_enabled = 1
            vim.g.vimtex_indent_bib_enabled = 1
            vim.g.vimtex_format_enabled = 0
            vim.g.vimtex_quickfix_autoclose_after_keystrokes = 3
            vim.g.vimtex_quickfix_ignore_filters = {
                "Underfull \\hbox",
                "Overfull \\hbox",
                "LaTeX Warning: .\\+ float specifier changed to",
            }
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "build",
                out_dir = "build",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                options = {
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }
        end,
    },
}

