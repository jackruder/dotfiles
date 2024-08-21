function telescope_setup()
    -- configure telescope bindings
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
    vim.keymap.set('n', "<leader>fg", builtin.live_grep, {})
    vim.keymap.set('n', "<leader>fb", builtin.buffers, {})
    vim.keymap.set('n', "<leader>fh", builtin.help_tags, {})

    vim.keymap.set('x', "ga", ":EasyAlign<CR>", {})
    vim.keymap.set('n', "ga", ":EasyAlign<CR>", {})

    local actions = require "telescope.actions"
    require('telescope').setup {
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            mappings = {
                i = {
                    ["<C-h>"] = actions.select_horizontal,
                },

                n = {
                    ["<C-h>"] = actions.select_horizontal,
                }
            }
        },
    }
end

return {
    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = function() 
        require("goto-preview").setup({
                width = 120, -- Width of the floating window
                height = 15, -- Height of the floating window
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
                default_mappings = true, -- Bind default mappings
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                references = { -- Configure the telescope UI for slowing the references cycling window.
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
                },
                -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
                focus_on_open = true,                                        -- Focus the floating window when opening it.
                dismiss_on_move = false,                                     -- Dismiss the floating window when moving the cursor.
                force_close = true,                                          -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
                bufhidden = "wipe",                                          -- the bufhidden option to set on the floating window. See :h bufhidden
                stack_floating_preview_windows = true,                       -- Whether to nest floating windows
                preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
            })
        end,
        config = true,                                                   -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },

    {
        'rmagatti/auto-session',
        lazy = false,
        dependencies = {
            'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
        },
        opts = {
            auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            -- log_level = 'debug',
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = telescope_setup,
    },

    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },
    { 'machakann/vim-sandwich' }, -- TODO: learn
    { 'junegunn/vim-easy-align' },

    {
        "doctorfree/cheatsheet.nvim", -- TODO: setup configure
        event = "VeryLazy",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
    },
    { 'tpope/vim-fugitive' }, -- TODO: figure out staging
}



--require('Comment').setup()
