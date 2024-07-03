vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_win_max_height = 24
vim.g.molten_auto_open_html_in_browser = true
vim.g.molten_cover_empty_lines = true
vim.g.molten_cover_lines_starting_with = {"@end", "@code"}
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

vim.keymap.set("n", "<localleader>ro", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<localleader>rc", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>",
    { silent = true, desc = "molten delete cell" })

require('molten.status').initialized() -- "Molten" or "" based on initialization information
require('molten.status').kernels() -- "kernel1 kernel2" list of kernels attached to buffer or ""
require('molten.status').all_kernels() -- same as kernels, but will show all kernels

-- I would recommend using the `link` option to link the values to colors from your color scheme
-- vim.api.nvim_set_hl(0, "MoltenOutputBorder", { ... })
vim.api.nvim_set_hl(0, "MoltenOutputBorder", { fg = "#61afef", bg = "#282c34", bold = true, italic = false })
vim.api.nvim_set_hl(0, "MoltenOutputText", { fg = "#add8e6", bg = "#282c34" })
vim.api.nvim_set_hl(0, "MoltenOutputError", { fg = "#e06c75", bg = "#282c34" })


local otter = require'otter'
otter.setup{
  lsp = {
    hover = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    -- `:h events` that cause the diagnostics to update. Set to:
    -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
    -- but more instant diagnostic updates
    diagnostic_update_events = { "BufWritePost" },
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
}

-- table of embedded languages to look for.
-- default = nil, which will activate
-- any embedded languages found
local languages = nil

-- enable completion/diagnostics
-- defaults are true
local completion = true
local diagnostics = true
-- treesitter query to look for embedded languages
-- uses injections if nil or not set
local tsquery = nil

otter.activate(languages, completion, diagnostics, tsquery)

require("jupytext").setup {
  style = "hydrogen",
  output_extension = "auto",  -- Default extension. Don't change unless you know what you are doing
  force_ft = nil,  -- Default filetype. Don't change unless you know what you are doing
  custom_language_formatting = {},
}
