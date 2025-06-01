require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true

vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
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

-- Set Aut Change Dir
vim.opt.autochdir = false

vim.opt.wildmenu = true

vim.opt.clipboard = "unnamedplus"
-- Use system clipboard
function no_paste(reg)
  return function(lines)
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
        ['+'] = no_paste('+'), -- Pasting disabled
        ['*'] = no_paste('*'), -- Pasting disabled
      },
    }

