local function molten_setup()
    vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_output_win_max_height = 24
    vim.g.molten_auto_open_html_in_browser = true
    vim.g.molten_cover_empty_lines = true
    vim.g.molten_cover_lines_starting_with = { "@end", "@code" }
    vim.g.molten_virt_text_output = true

    vim.keymap.set("n", "<localleader>ip", function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= nil then
            -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
            venv = string.match(venv, "/.+/(.+)")
            vim.cmd(("MoltenInit %s"):format(venv))
        else
            vim.cmd("MoltenInit python3")
        end
    end, { desc = "Initialize Molten for python3", silent = true })

    vim.keymap.set(
        "n",
        "<localleader>ro",
        ":MoltenEvaluateOperator<CR>",
        { silent = true, desc = "run operator selection" }
    )
    vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
    vim.keymap.set("n", "<localleader>rc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
    vim.keymap.set(
        "v",
        "<localleader>r",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { silent = true, desc = "evaluate visual selection" }
    )
    vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })

    require("molten.status").initialized() -- "Molten" or "" based on initialization information
    require("molten.status").kernels()     -- "kernel1 kernel2" list of kernels attached to buffer or ""
    require("molten.status").all_kernels() -- same as kernels, but will show all kernels

    -- I would recommend using the `link` option to link the values to colors from your color scheme
    -- vim.api.nvim_set_hl(0, "MoltenOutputBorder", { ... })
    vim.api.nvim_set_hl(0, "MoltenOutputBorder", { fg = "#61afef", bg = "#282c34", bold = true, italic = false })
    vim.api.nvim_set_hl(0, "MoltenOutputText", { fg = "#add8e6", bg = "#282c34" })
    vim.api.nvim_set_hl(0, "MoltenOutputError", { fg = "#e06c75", bg = "#282c34" })
end

local neorg_opts = {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp"
            }
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes",
                    comptag = "~/compTaG/notes"
                },
            },
        },
        ["core.export.markdown"] = {
            config = {
                extensions = "all",

            }
        },
        ["core.export"] = {},
        ["core.latex.renderer"] = {
            config = {
                conceal = true,
                scale = 0.8,
            }
        },

        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    -- Unmaps any Neorg key from the `norg` mode
                    --keybinds.unmap("norg", "n", "gtd")
                    --keybinds.unmap("norg", "n", keybinds.leader .. "nn")

                    -- Binds the `gtd` key in `norg` mode to execute `:echo 'Hello'`
                    --keybinds.map("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
                    keybinds.map("norg", "n", "<Leader>nlg", "core.looking-glass.magnify-code-block")

                    -- Remap unbinds the current key then rebinds it to have a different action
                    -- associated with it.
                    -- The following is the equivalent of the `unmap` and `map` calls you saw above:
                    -- keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")

                    -- Sometimes you may simply want to rebind the Neorg action something is bound to
                    -- versus remapping the entire keybind. This remap is essentially the same as if you
                    -- did `keybinds.remap("norg", "n", "<C-Space>, "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>")
                    --keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_done")

                    -- Want to move one keybind into the other? `remap_key` moves the data of the
                    -- first keybind to the second keybind, then unbinds the first keybind.
                    --keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>t")
                end,
            }
        }
    }
}

return {
    {
        "nvim-neorg/neorg",
        lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        opts = neorg_opts,
    },
    {
        "3rd/image.nvim",
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
                html = {
                    enabled = false,
                },
                css = {
                    enabled = false,
                },
            },
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true,                                      -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        },
    },
    {
        'jmbuhr/otter.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'neovim/nvim-lspconfig',
        },
        opts = {
            lsp = {
                hover = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
                -- `:h events` that cause the diagnostics to update. Set to:
                -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
                -- but more instant diagnostic updates
                diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
            },
            buffers = {
                -- if set to true, the filetype of the otterbuffers will be set.
                -- otherwise only the autocommand of lspconfig that attaches
                -- the language server will be executed without setting the filetype
                set_filetype = false,
                -- write <path>.otter.<embedded language extension> files
                -- to disk on save of main buffer.
                -- usefule for some linters that require actual files
                -- otter files are deleted on quit or main buffer close
                write_to_disk = true,
            },
            strip_wrapping_quote_characters = { "'", '"', "`" },
            -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
            -- When true, otter handles these cases fully. This is a (minor) performance hit
            handle_leading_whitespace = true,
        },
    },
    { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
        -- for complete functionality (language features)
        'quarto-dev/quarto-nvim',
        ft = { 'quarto' },
        dev = false,
        opts = {
            debug = false,
            closePreviewOnExit = true,
            lspFeatures = {
                enabled = true,
                chunks = "curly",
                languages = { "r", "python", "julia", "bash", "html" },
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" },
                },
                completion = {
                    enabled = true,
                },
            },
            codeRunner = {
                enabled = true,
                default_method = "slime", -- "molten", "slime", "iron" or <function>
                ft_runners = {},          -- filetype to runner, ie. `{ python = "molten" }`.
                -- Takes precedence over `default_method`
                never_run = { 'yaml' },   -- filetypes which are never sent to a code runner
            },
        },
        dependencies = {
            -- for language features in code cells
            -- configured in lua/plugins/lsp.lua and
            -- added as a nvim-cmp source in lua/plugins/completion.lua
            'jmbuhr/otter.nvim',
        },
        -- define some keybinds
        config = function()
            local runner = require("quarto.runner")
            vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
            vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
            vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
            vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
            vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
            vim.keymap.set("n", "<localleader>RA", function()
                runner.run_all(true)
            end, { desc = "run all cells of all languages", silent = true })

            local quarto = require('quarto')
            vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true })
        end,
    },

    { -- directly open ipynb files as quarto docuements
        -- and convert back behind the scenes
        'GCBallesteros/jupytext.nvim',
        opts = {
            custom_language_formatting = {
                python = {
                    extension = 'qmd',
                    style = 'quarto',
                    force_ft = 'quarto',
                },
                r = {
                    extension = 'qmd',
                    style = 'quarto',
                    force_ft = 'quarto',
                },
            },
        },
    },
    { -- send code from python/r/qmd documets to a terminal or REPL
        -- like ipython, R, bash
        'jpalardy/vim-slime',
        dev = false,
        init = function()
            vim.b['quarto_is_python_chunk'] = false
            Quarto_is_in_python_chunk = function()
                require('otter.tools.functions').is_otter_language_context 'python'
            end

            vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

            vim.g.slime_target = 'neovim'
            vim.g.slime_no_mappings = true
            vim.g.slime_python_ipython = 1
        end,
        config = function()
            vim.g.slime_input_pid = false
            vim.g.slime_suggest_default = true
            vim.g.slime_menu_config = false
            vim.g.slime_neovim_ignore_unlisted = true

            local function mark_terminal()
                local job_id = vim.b.terminal_job_id
                vim.print('job_id: ' .. job_id)
            end

            local function set_terminal()
                vim.fn.call('slime#config', {})
            end
            vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
            vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
        end,
    },
    { -- paste an image from the clipboard or drag-and-drop
        'HakonHarnes/img-clip.nvim',
        event = 'BufEnter',
        ft = { 'markdown', 'quarto', 'latex' },
        opts = {
            default = {
                dir_path = 'img',
            },
            filetypes = {
                markdown = {
                    url_encode_path = true,
                    template = '![$CURSOR]($FILE_PATH)',
                    drag_and_drop = {
                        download_images = false,
                    },
                },
                quarto = {
                    url_encode_path = true,
                    template = '![$CURSOR]($FILE_PATH)',
                    drag_and_drop = {
                        download_images = false,
                    },
                },
            },
        },
        config = function(_, opts)
            require('img-clip').setup(opts)
            vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
        end,
    },

    { -- preview equations
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>qm', ':lua require"nabla".toggle_virt()<cr>', desc = 'toggle [m]ath equations' },
        },
    },

    {
        'benlubas/molten-nvim',
        enabled = false,
        build = ':UpdateRemotePlugins',
        init = function()
            vim.g.molten_image_provider = 'image.nvim'
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
        end,
        keys = {
            { '<leader>mi', ':MoltenInit<cr>',           desc = '[m]olten [i]nit' },
            {
                '<leader>mv',
                ':<C-u>MoltenEvaluateVisual<cr>',
                mode = 'v',
                desc = 'molten eval visual',
            },
            { '<leader>mr', ':MoltenReevaluateCell<cr>', desc = 'molten re-eval cell' },
        },
    },
    {
        'nvim-treesitter/playground',
    }


}
