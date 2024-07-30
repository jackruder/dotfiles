--- TREESITTER -----
-- require("nvim-treesitter.configs").setup({
-- 	-- Install parsers synchronously (only applied to `ensure_installed`)
-- 	sync_install = false,
--
-- 	-- Automatically install missing parsers when entering buffer
-- 	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
-- 	auto_install = false,
--
-- 	-- List of parsers to ignore installing (or "all")
-- 	ignore_install = { "latex", "bibtex" },
-- 	highlight = {
-- 		enable = true,
-- 	},
-- 	incremental_selection = {
-- 		enable = true,
-- 		keymaps = {
-- 			init_selection = "gnn", -- set to `false` to disable one of the mappings
-- 			node_incremental = "grn",
-- 			scope_incremental = "grc",
-- 			node_decremental = "grm",
-- 		},
-- 	},
-- 	indent = {
-- 		enable = true,
-- 	},
-- })

--- COMPLETION + SNIPPETS ---

local cmp = require("cmp")

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

--vim.o.completeopt = "menuone,noselect,preview"
local lspkind = require("lspkind")
cmp.setup({
	--preselect = cmp.PreselectMode.None,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			ls.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
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
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
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

-- Set up lspconfig.
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
		"rust_analyzer",
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

local on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client, bufnr)
end
vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

-- fish
-- lspconfig.fish_lsp.setup({ capabilities = capabilities, on_attach = on_attach })

-- grammar
lspconfig.ltex.setup({ capabilities = capabilities, on_attach = on_attach })

-- latex
lspconfig.texlab.setup({ capabilities = capabilities, on_attach = on_attach })

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

-- r
lspconfig.r_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- rust
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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
	on_attach = on_attach,
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
	on_attach = on_attach,
	capabilities = capabilities,
}))
