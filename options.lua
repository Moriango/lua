require "nvchad.options"

vim.scriptencoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.foldmethod = "manual"
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.hidden = true

-- to enable cursorline!
vim.o.cursorlineopt = 'both'

-- vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
-- Highlights the screen line of the cursor 
vim.opt.cursorline = true

-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Wrap lines at convenient points
vim.opt.linebreak = true

-- Enables persistent undo
vim.opt.undofile = true

-- Ignore case
vim.opt.wildignorecase = true

-- Enable list mode to show whitespace characters
vim.o.list = true

-- Define what characters to display
vim.o.listchars = "tab:▸ ,trail:·,extends:»,precedes:«,eol:↵"

-- Set Aut Change Dir
vim.opt.autochdir = false

-- Enable wildmenu for command-line completion
vim.opt.wildmenu = true

-- Set grep program to ripgrep
vim.opt.grepprg = "rg --vimgrep"

-- Set grep format to match ripgrep output
vim.opt.grepformat = "%f:%l:%c:%m"

-- Use system clipboard
local function no_paste()
  return function()
    -- Do nothing! We can't paste with osc52
  end
end
vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      paste = {
        ['+'] = no_paste(), -- Pasting disabled
        ['*'] = no_paste(), -- Pasting disabled
      },
    }
