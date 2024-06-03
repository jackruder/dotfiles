local cmp = require'cmp'

local luasnip  = require('luasnip')
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snippets"})


cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
		    if luasnip.expandable() then
			luasnip.expand()
		    else
			cmp.confirm({
			    select = true,
			})
		    end
		else
		    fallback()
		end
	end),
	['<Tab>'] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_next_item()
	      elseif luasnip.locally_jumpable(1) then
		luasnip.jump(1)
	      else
		fallback()
	      end
	    end, { "i", "s" }),
	['<S-Tab>'] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_prev_item()
	      elseif luasnip.locally_jumpable(-1) then
		luasnip.jump(-1)
	      else
		fallback()
	      end
	    end, { "i", "s" }),
	['<C-g>'] = cmp.mapping(
      	cmp.mapping.complete({
            config = {
              sources = cmp.config.sources({{ name = 'cmp_ai' }}),
            },
            }),
            { 'i' }
    	),
    	}),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'rpncalc' },
      { name = 'vimtex', },
      {
            name = "spell",
            option = {
                keep_all_entries = false,
                enable_in_context = function()
			return require('cmp.config.context').in_treesitter_capture('spell')
                end,
                preselect_correct_word = true,
            },
      },
      { name = "neorg" },

    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup()

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local cmp_ai = require('cmp_ai.config')

cmp_ai:setup({
  max_lines = 1000,
  provider = 'OpenAI',
  provider_options = {
    model = 'gpt-4-turbo',
  },
  notify = true,
  notify_callback = function(msg)
    vim.notify(msg)
  end,
  run_on_every_keystroke = true,
  ignored_file_types = {
    -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  },
})

local lspconfig = require('lspconfig')
-- latex

vim.g.vimtex_view_method='zathura'

-- PYTHON
lspconfig.pyright.setup {
	capabilities = capabilities
}

-- LUA
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
	Lua = {
        diagnostics = {
	    globals = { 'vim' }
            }
        }
    }
}
