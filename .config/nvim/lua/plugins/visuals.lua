-- -- word highlighting
-- require("stcursorword").setup({
--     max_word_length = 100, -- if cursorword length > max_word_length then not highlight
--     min_word_length = 2,   -- if cursorword length < min_word_length then not highlight
--     excluded = {
--         filetypes = {
--             "TelescopePrompt",
--         },
--         buftypes = {
--             -- "nofile",
--             -- "terminal",
--         },
--         patterns = { -- the pattern to match with the file path
--         },
--     },
--     highlight = {
--         underline = true,
--         fg = nil,
--         bg = nil,
--     },
-- })

-- end of line notification colorbar
require("deadcolumn").setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "rose-pine",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = {
			{
				"copilot",
				symbols = {
					status = {
						icons = {
							enabled = " ",
							sleep = " ", -- auto-trigger disabled
							disabled = " ",
							warning = " ",
							unknown = " ",
						},
						hl = {
							enabled = "#50FA7B",
							sleep = "#AEB7D0",
							disabled = "#6272A4",
							warning = "#FFB86C",
							unknown = "#FF5555",
						},
					},
					spinners = require("copilot-lualine.spinners").dots,
					spinner_color = "#6272A4",
				},
				show_colors = true,
				show_loading = true,
			},
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
vim.g.rose_pine_enable_italics = true
vim.cmd.colorscheme("rose-pine")

local theme_colors = require("catppuccin.palettes").get_palette("macchiato")
local rose_pine_colors = {
	"#191724", -- rgb(25, 23, 36), hsl(249deg, 22%, 12%)
	"#1f1d2e", -- rgb(31, 29, 46), hsl(247deg, 23%, 15%)
	"#26233a", -- rgb(38, 35, 58), hsl(248deg, 25%, 18%)
	"#6e6a86", -- rgb(110, 106, 134), hsl(249deg, 12%, 47%)
	"#908caa", -- rgb(144, 140, 170), hsl(248deg, 15%, 61%)
	"#e0def4", -- rgb(224, 222, 244), hsl(245deg, 50%, 91%)
	"#eb6f92", -- rgb(235, 111, 146), hsl(343deg, 76%, 68%)
	"#f6c177", -- rgb(246, 193, 119), hsl(35deg, 88%, 72%)
	"#ebbcba", -- rgb(235, 188, 186), hsl(2deg, 55%, 83%)
	"#31748f", -- rgb(49, 116, 143), hsl(197deg, 49%, 38%)
	"#9ccfd8", -- rgb(156, 207, 216), hsl(189deg, 43%, 73%)
	"#c4a7e7", -- rgb(196, 167, 231), hsl(267deg, 57%, 78%)
	"#21202e", -- rgb(33, 32, 46), hsl(244deg, 18%, 15%)
	"#403d52", -- rgb(64, 61, 82), hsl(249deg, 15%, 28%)
	"#524f67", -- (no rgb and hsl provided)
}
require("tiny-devicons-auto-colors").setup({
	-- concatenate the colors from the theme and the colors from the palette
	colors = vim.tbl_flatten({ rose_pine_colors, theme_colors }),
})
