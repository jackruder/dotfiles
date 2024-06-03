-- word highlighting
require("stcursorword").setup({
        max_word_length = 100, -- if cursorword length > max_word_length then not highlight
        min_word_length = 2, -- if cursorword length < min_word_length then not highlight
        excluded = {
            filetypes = {
                "TelescopePrompt",
            },
            buftypes = {
                -- "nofile",
                -- "terminal",
            },
            patterns = { -- the pattern to match with the file path
            },
        },
        highlight = {
            underline = true,
            fg = nil,
            bg = nil,
        },
    })


-- end of line notification colorbar
require('deadcolumn').setup()

require('lualine').setup { options = {theme = "catppuccin"}}

vim.cmd.colorscheme("catppuccin-mocha")
local theme_colors = require("catppuccin.palettes").get_palette("mocha")

require('tiny-devicons-auto-colors').setup({
    colors = theme_colors,
})
