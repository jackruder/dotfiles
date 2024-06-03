-- configure telescope bindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', "<leader>fg", builtin.live_grep, {})
vim.keymap.set('n', "<leader>fb", builtin.buffers, {})
vim.keymap.set('n', "<leader>fh", builtin.help_tags, {})

vim.keymap.set('x', "ga", ":EasyAlign<CR>", {})
vim.keymap.set('n', "ga", ":EasyAlign<CR>", {})

local actions = require "telescope.actions"
require('telescope').setup{
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
