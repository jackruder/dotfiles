-- ROCKS --

local rocks_config = {
rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

-- GENERAL  --


vim.opt.number = true
vim.opt.relativenumber = true -- Enable relative line numbers
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.smartindent = true    -- Automatically indent new lines
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false -- Disable line wrapping
vim.opt.cursorline = true
vim.opt.colorcolumn = "79"

vim.opt.autochdir = false
--
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- colors
vim.opt.termguicolors = true

-- popup notifications
-- vim.notify = require("notify")

vim.g.vimtex_view_method = 'zathura'

vim.opt.splitbelow = true
vim.opt.splitright = true
-- convert the above keymappings to the lua equivalents
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true })

-- misc
--require("hardtime").setup()
