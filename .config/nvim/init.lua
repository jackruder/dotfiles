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
vim.opt.conceallevel = 2

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.autochdir = false
--
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- colors
vim.opt.termguicolors = true

-- popup notifications
-- vim.notify = require("notify")

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", "<A-S-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.keymap.set("t", "<A-S-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.keymap.set("t", "<A-S-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.keymap.set("t", "<A-S-l>", "<C-\\><C-N><C-w>l", { noremap = true })
vim.keymap.set("i", "<A-S-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.keymap.set("i", "<A-S-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.keymap.set("i", "<A-S-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.keymap.set("i", "<A-S-l>", "<C-\\><C-N><C-w>l", { noremap = true })
vim.keymap.set("n", "<A-S-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<A-S-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<A-S-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<A-S-l>", "<C-w>l", { noremap = true })

require("config.lazy")
