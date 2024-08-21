function molten_setup()
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
                write_to_disk = false,
            },
            strip_wrapping_quote_characters = { "'", '"', "`" },
            -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
            -- When true, otter handles these cases fully. This is a (minor) performance hit
            handle_leading_whitespace = true,
        },
    },
    { 'benlubas/molten-nvim' },
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "hydrogen",
            output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
            force_ft = nil,            -- Default filetype. Don't change unless you know what you are doing
            custom_language_formatting = {},
        },
        config = true,
        -- Depending on your nvim distro or config you may need to make the loading not lazy
        -- lazy=false,
    },
}

-- -- table of embedded languages to look for.
-- -- default = nil, which will activate
-- -- any embedded languages found
-- local languages = nil
--
-- -- enable completion/diagnostics
-- -- defaults are true
-- local completion = true
-- local diagnostics = true
-- -- treesitter query to look for embedded languages
-- -- uses injections if nil or not set
-- local tsquery = nil
-- TODO: figure out when to call activate
-- otter.activate(languages, completion, diagnostics, tsquery)
