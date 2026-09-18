require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = false, silent = false}

-- MAPPINGS --

-- Window shortcuts: change layouts, create splits, close windows, and rotate buffers.
map("n", "<leader>m", ":only<CR>", { noremap = true, silent = true, desc = "Makes the current split screen fullscreen"})

-- Appearance shortcuts: toggle transparency and word wrapping.
map("n", "<leader>tp", ":lua require('base46').toggle_transparency()<CR>", { noremap = true, silent = true, desc = "Toggle Background Transparency" })
map("n", "ZZ", "<cmd>WordWrapToggle<CR>", { desc = "Toggles word wrap", noremap = true, silent=false })

-- Mode shortcuts: enter command mode and leave insert or terminal mode.
map({"n", "v"}, ";", ":", { desc = "CMD enter command mode" })
map({"n","i","v"}, "jk", "<ESC>")
map("t", "<Esc>",[[<C-\><C-n>]], { desc = "Exit from terminal mode"})
map("t", "jk",[[<C-\><C-n>]], { desc = "Exit from terminal mode"})

-- File navigation shortcuts: open, close, and manage the file tree.
map({"n","i","v"}, "<leader>ee", ":NvimTreeToggle<CR>", { desc = "Toggles the file tree", noremap = true, silent=true })
map("n", "<leader>zz", ":NvimTreeCollapse<CR>",{ noremap = true, silent = true, desc = "Closes File Tree"} )

-- Cursor movement shortcuts: move within lines, scroll, center, and reorder visual lines.
map({"n","v"}, "ee", "$", { desc = "Move cursor to the end of the current line", noremap = true, silent=true })
map({"n","v"}, "ba", "^", { desc = "Move cursor to the begginning of the current line", noremap = true, silent=true })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves the current line up", noremap = true, silent=true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves the current line up", noremap = true, silent=true })

-- Plugin management shortcuts: open the Lazy plugin manager.
map({"n","i"}, "<leader>lz", ":Lazy<CR>", { desc = "Opens Lazy"})

-- Tmux Navigation
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Move left" })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Move down" })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Move up" })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Move right" })

-- Page movement shortcuts: move by pages or jump to the top and bottom of a buffer.
map({"n"}, "D", "<C-d>zz", { desc = "Moves the cursor down half a page and centers it.", noremap = true, silent=true })
map({"n"}, "U", "<C-u>zz", { desc = "Moves the cursor up half a page and centers it.", noremap = true, silent=true })
map("n", "G", "Gzz", { desc = "Moves the cursor to the bottom of the page and centers the screen", noremap = true, silent=true })
map("n", "gg", "ggzz", { desc = "Moves the cursor to the top of the page and centers the screen", noremap = true, silent=true })

-- Window and buffer shortcuts: create, close, rotate, and switch split windows or buffers.
map("n", "hs", ":split<Return>", { desc = "Splits tab Horizontally", noremap = true, silent=true })
map("n", "vs", ":vsplit<CR>", { desc = "Splits tab Vertically", noremap = true, silent=true })
map("n", "<leader>x", "<C-w>c", { desc =  "Closes the current split window", noremap=true, silent=true})
map("n", "<leader>q", ":CloseBufferKeepSplit<CR>", { noremap=true, silent=true})
map("n", ",", "<cmd>RotateSplitScreens<CR>", { noremap = true, silent = true, desc = "Rotate all split screens" })

-- Terminal shortcuts: open a shell in a vertical split.
map("n", "<leader>st", ":SplitToTerminalVertically<CR>", { desc = "Opens a terminal Vertically in current working directory"})

-- Search shortcuts: search intelligently, replace the word under the cursor, and rename symbols.
map("n", "n", ":lua smart_search('next')<CR>", {desc = "Smart search next", noremap = true, silent = true})
map("n", "N", ":lua smart_search('prev')<CR>", {desc = "Smart search previous", noremap = true, silent = true})

-- Replace words
map("n", "<leader>cw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], { desc = "Replace word under cursor globally and ask"})
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "LSP: Rename"})

--- Clear search result
map("n", "ff", ":lua clear_search()<CR>", { desc = "Clear search pattern and highlight", silent=true})

-- Project shortcuts: change to a project and add project directories to the project database.
map("n", "cd", function()
  open_telescope_in_normal "CdProject"
end, { desc = "Cd Project, Change working directory"})
map("n", "fo", "<cmd>OldFilesNormal<CR>", { desc = "Telescope: old files"})
map("n", "<leader>fo", function()
  open_telescope_in_normal "Telescope oldfiles"
end, { desc = "Telescope: old files"})
map("n", "cda", "<cmd>CdProjectAdd<CR>", { desc = "Cd Project, add current project's directory to the databse(json file)"})
map("n", "cdm", "<cmd>CdProjectManualAdd<CR>", { desc = "Cd Project, Manually add project's directory to the databse(json file)"})

-- Diagnostic jumps notify when the list wraps around.
-- d[ / d] jump the quickfix list when it's open, otherwise fall back to diagnostics.
map("n", "d[", ":lua quickfix_or_diagnostic_jump('next')<CR>", { desc = "Go to next quickfix item (or diagnostic)", noremap = true, silent = true })
map("n", "[d", ":lua quickfix_or_diagnostic_jump('next')<CR>", { desc = "Go to next quickfix item (or diagnostic)", noremap = true, silent = true })
map("n", "d]", ":lua quickfix_or_diagnostic_jump('prev')<CR>", { desc = "Go to previous quickfix item (or diagnostic)", noremap = true, silent = true })
map("n", "]d", ":lua quickfix_or_diagnostic_jump('prev')<CR>", { desc = "Go to previous quickfix item (or diagnostic)", noremap = true, silent = true })

-- Marks shortcuts: jump to the next or previous mark.
map("n", "m", "<cmd>lua require('marks').next()<CR>", { desc = "Jump to next mark", noremap = true, silent = true })
map("n", "m,", "<cmd>lua require('marks').prev()<CR>", { desc = "Jump to previous mark", noremap = true, silent = true })
map("n", "dm", ":lua delete_mark()<CR>", { desc = "Delete a mark" })
map("n", "dM", ":lua delete_all_marks()<CR>", { desc = "Delete all marks in the current buffer" })

-- Editing shortcuts: indent, unindent, delete, and yank text with shorter key sequences.
map("n", "t", ">>", { noremap = true, silent=true })
map("n", "T", "<<", { noremap = true, silent=true })
map("v", "t", ">gv", { noremap = true, silent=true })
map("v", "T", "<gv", { noremap = true, silent=true })

map("n", "de", "D", opts)
map("n", "db", "d0", opts)

map("n", "ye", "y$", { noremap = true, silent = true, desc = "Yank to end of the line"} )

--- History and register shortcuts: navigate the change list and inspect registers.
map("n", "g.", "g;", { noremap = true, silent = true, desc = "Go to next edit"} )

-- Python shortcut: open an IPython terminal in a vertical split.
map("n", "<leader>p", ":vsplit | terminal ipython<CR>", { desc = "Open a terminal with Ipython", noremap=true, silent=true})

map("n", "rr", ":reg<CR>")

-- Terminal input shortcuts: navigate command history and complete terminal input.
map("t", "<C-k>", "<UP>", { noremap = true, silent=true, desc = "Scroll up through previous inputs/commands"})
map("t", "<C-j>", "<DOWN>", { noremap = true, silent=true, desc = "Scroll down through previous inputs/commands"})
map("t", "<C-l>", "<Right>", { noremap = true, silent=true, desc = "Autocompletes in terminal mode"})

-- Open in VSCode
map("n", "vv", ":silent !code %<CR>", { noremap = true, silent = true, desc = "Opens current file in VS Code" })
map("n", "<leader>vv", ":silent !code . %<CR>", { noremap = true, silent = true, desc = "Opens current working directory and file in VS Code" })

-- Buffer shortcuts: close the current buffer and refresh or exit Neovim.
map({"n","t",}, "qq", ":lua close_nvim_tree_and_buffer()<CR>", { noremap = true, silent = true, desc = "Deletes/Closes buffer window"})
map("n", "<leader>rb", ":lua refresh_buffer()<CR>",{ noremap = true, silent = true, desc = "Refreshes Current Buffer"})
map("n", "<leader>qa", ":qa!<CR>",{ noremap = true, silent = true, desc = "Closes All Buffers"} )

-- Git shortcuts: toggle blame and inspect or navigate hunks.
map("n", "gb", ":silent GitBlameToggle<CR>:echom 'Git Blame Toggle'<CR>", { desc = "Toggles GitBlame", silent = true, noremap = true })
map("n", "[g", ":lua gitsigns_preview()<CR>", { desc = "Opens git signs and jumps to next hunk", noremap = true})
map("n", "g[", ":lua gitsigns_preview()<CR>", { desc = "Opens git signs and jumps to next hunk", noremap = true})
map("n", "]g", ":lua gitsigns_previous_hunk()<CR>", { desc = "Jump to previous hunk and center", noremap = true, silent = true })
map("n", "g]", ":lua gitsigns_previous_hunk()<CR>", { desc = "Jump to previous hunk and center", noremap = true, silent = true })

-- Buffer and workspace utility shortcuts: select the whole buffer and count buffers.
map("n", "<leader>h", "<cmd>HighlightPage<CR>", { noremap = true, silent = true, desc = "Highlight the entire buffer"})

-- Quickfix shortcuts: navigate through and close the quickfix list.
map("n", "[c", ":cnext<CR>", { noremap = true, silent = true, desc = "Go to next item in quickfix list"})
map("n", "]c", ":cprev<CR>", { noremap = true, silent = true, desc = "Go to previous item in quickfix list"})
map("n", "CC", ":cclose<CR>", { noremap = true, silent = true, desc = "Close the quickfix list"})

-- File information shortcuts: copy the current filename, full filename, or directory path.
map("n", "yn", ":lua copy_filename_without_extension()<CR>", { desc = "Copy filename to clipboard" })
map("n", "yfn", ":lua copy_filename()<CR>", { desc = "Copy filename to clipboard" })
map("n", "yp", ":lua copy_file_directory()<CR>", { desc = "Copy full file path to clipboard" })

-- Buffer count shortcut: report the number of listed buffers.
map("n", "bc", ":lua print_buffer_count()<CR>")

-- Directory shortcuts: count files, show the working directory, and move to its parent.
map("n", "<leader>fc", ":lua count_files_in_directory()<CR>", { desc = "Count files in current directory", noremap = true })
map("n", "MM", ":lua change_current_directory()<CR>", { desc = "Autochdir setting", silent = true, noremap = true })
map("n", "_", ":lua move_to_parent_directory()<CR>", { desc = "Moving working directory up one level", noremap = true })

-- Window resizing shortcuts: adjust split dimensions with Alt plus H, J, K, or L.
vim.keymap.set("n", "<A-h>", ":vertical resize -5<CR>", { noremap = true, silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<A-j>", ":resize -5<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<A-k>", ":resize +5<CR>", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<A-l>", ":vertical resize +5<CR>", { noremap = true, silent = true, desc = "Increase window width" })

-- Swap the default visual-line and visual-block commands.
vim.keymap.set({'n','v','o'}, 'V', '<C-q>', { noremap = true, silent = true })
vim.keymap.set({'n','v','o'}, '<C-v>', 'V', { noremap = true, silent = true })

-- FUNCTIONS -- 

-- Helper functions used by the shortcut declarations above.

_G.open_telescope_in_normal = function(command)
  local telescope_config = require "telescope.config"
  local previous_mode = telescope_config.values.initial_mode
  local group = vim.api.nvim_create_augroup("CdProjectTelescopeMode", { clear = true })

  telescope_config.values.initial_mode = "normal"
  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopeFindPre",
    group = group,
    once = true,
    callback = function()
      telescope_config.values.initial_mode = previous_mode
    end,
  })

  vim.cmd(command)
  vim.schedule(function()
    if vim.fn.mode() == "i" then
      vim.cmd "stopinsert"
    end
  end)
end

-- Prompt for and delete one mark.
_G.delete_mark = function()
  vim.ui.input({ prompt = "Delete mark: " }, function(mark)
    if not mark or mark == "" then
      return
    end

    if not mark:match("^[A-Za-z]$") then
      vim.notify("Enter one letter mark", vim.log.levels.WARN)
      return
    end

    vim.cmd("delmarks " .. mark)
  end)
end

-- Delete every mark in the current buffer.
_G.delete_all_marks = function()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z")
  ---@diagnostic disable-next-line: undefined-field
  require("marks").refresh(true)
end

-- Search for the word under the cursor and move to the next or previous match.
_G.smart_search = function(direction)
  local cursor_word = vim.fn.expand("<cword>")
  if cursor_word == "" then
    return
  end

  local search_register = vim.fn.getreg("/")
  local last_smart_search = vim.g.last_smart_search or ""
  local move_cmd = (direction == "next") and "normal! n" or "normal! N"

  if search_register ~= "" and search_register ~= last_smart_search then
    local ok, err = pcall(function()
      vim.cmd(move_cmd)
    end)
    if not ok and err and err:match("E486") then
      return
    end
    return
  end

  local escaped = vim.fn.escape(cursor_word, "\\[].*~")
  local pattern = "\\C\\<" .. escaped .. "\\>"
  vim.fn.setreg("/", pattern)
  vim.g.last_smart_search = pattern

  local search_count = vim.fn.searchcount({ maxcount = 1 })
  if search_count and search_count.total == 0 then
    return
  end

    ---@diagnostic disable-next-line: param-type-mismatch;
  local ok, err = pcall(vim.cmd, move_cmd)
  if not ok and err and err:match("E486") then
    return
  end
end

-- Clear the search state, notifications, highlights, and floating windows.
_G.clear_search = function()
  vim.fn.setreg("/", "")
  vim.cmd("nohlsearch")
  local ok, notify = pcall(require, "notify")
  if ok and notify.dismiss then pcall(notify.dismiss) end
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(window)
    if config.relative ~= "" then pcall(vim.api.nvim_win_close, window, true) end
  end
  vim.cmd("redraw!")
  print("Search Cleared")
end

-- Open the location list (populating it fresh) if needed, then jump within it.
_G.quickfix_or_diagnostic_jump = function(direction)
  if vim.tbl_isempty(vim.diagnostic.get()) then
    vim.notify("No diagnostic errors", vim.log.levels.INFO)
    return
  end

  _G.open_diagnostics_loclist()

  local loclist = vim.fn.getloclist(0)
  if vim.tbl_isempty(loclist) then
    vim.notify("No location list entries", vim.log.levels.INFO)
    return
  end

  local ok = pcall(vim.cmd, direction == "next" and "lnext" or "lprev")
  if not ok then
    local fallback = direction == "next" and "lfirst" or "llast"
    local fallback_ok = pcall(vim.cmd, fallback)
    if not fallback_ok then
      vim.cmd("lclose")
      vim.notify("No more diagnostics", vim.log.levels.INFO)
      return
    end
  end

  vim.cmd("normal! zz")
end

-- Close the file tree and delete the current buffer.
_G.close_nvim_tree_and_buffer = function()
  local nvim_tree_api = require('nvim-tree.api')
  if nvim_tree_api.tree.is_visible() then
    vim.cmd('wincmd l')
    nvim_tree_api.tree.close()
  end
  vim.cmd('bd!')
end

-- Reload the current buffer from disk.
_G.refresh_buffer = function()
  print("Refreshed Buffer")
  vim.cmd('edit')
end

-- Copy the current filename without its extension.
_G.copy_filename_without_extension = function()
  vim.fn.setreg("a", vim.fn.expand("%:t:r"))
  print("Copied filename to \"a\" register")
end

-- Copy the current filename with its extension.
_G.copy_filename = function()
  vim.fn.setreg("a", vim.fn.expand("%:t"))
  print("Copied file to \"a\" register")
end

-- Copy the directory containing the current file.
_G.copy_file_directory = function()
  vim.fn.setreg("a", vim.fn.expand("%:p:h"))
  print("Copied filename to \"a\" register")

end

-- Print the number of listed buffers.
_G.print_buffer_count = function()
  print('Buffer count: ' .. #vim.fn.getbufinfo({buflisted=1}))
end

-- Count regular files in the current directory.
_G.count_files_in_directory = function()
  local handle = io.popen('find . -maxdepth 1 -type f | wc -l')
  if handle then
    local result = tonumber(handle:read("*a"):match("^%s*(.-)%s*$"))
    handle:close()
    print("Files in current directory: " .. result)
  else
    print("Error counting files")
  end
end

-- Print the current working directory after refreshing autochdir.
_G.change_current_directory = function()
  vim.cmd("set autochdir")
  vim.cmd("set noautochdir")
  print("Changed Directories: " .. vim.fn.getcwd())
end

-- Change to the parent of the current working directory.
_G.move_to_parent_directory = function()
  vim.cmd("cd ../")
  print("Current directory: " .. vim.fn.getcwd())
end

-- Enable or disable diagnostics for the current Neovim session.
_G.toggle_diagnostic = function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    print("Diagnostics Disabled")
  else
    vim.diagnostic.enable()
    print("Diagnostics Enabled")
  end
end

-- Tracks the last real editing window so navigation doesn't get stuck
-- if focus ends up in the gitsigns preview popup (e.g. after a delay).
local gitsigns_last_win = nil

local function gitsigns_restore_main_win()
  local cur = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(cur).relative == "" then
    gitsigns_last_win = cur
  elseif gitsigns_last_win and vim.api.nvim_win_is_valid(gitsigns_last_win) then
    vim.api.nvim_set_current_win(gitsigns_last_win)
  end
end

_G.gitsigns_preview = function()
  gitsigns_restore_main_win()
  local gitsigns = require("gitsigns")
  ---@diagnostic disable-next-line: undefined-field
  gitsigns.nav_hunk("next", {
    wrap = true,
    foldopen = true,
    navigation_message = true,
    greedy = false,
    count = 1,
    target = "all",
  }, function()
  ---@diagnostic disable-next-line: undefined-field
    gitsigns.preview_hunk()
  end)
  vim.cmd("normal! zz")
end

_G.gitsigns_previous_hunk = function()
  gitsigns_restore_main_win()
  local gitsigns = require("gitsigns")
  ---@diagnostic disable-next-line: undefined-field
  gitsigns.nav_hunk("prev", {
    wrap = true,
    foldopen = true,
    navigation_message = true,
    greedy = false,
    count = 1,
    target = "all",
  }, function()
  ---@diagnostic disable-next-line: undefined-field
    gitsigns.preview_hunk()
  end)
  vim.cmd("normal! zz")
end

_G.sendYankToARegister = function()
  if vim.v.event.operator == "y" then
    vim.fn.setreg("a", vim.fn.getreg('"'), vim.fn.getregtype('"'))
  end
end

vim.schedule(function()
  require "mappings"
  if type(_G.clear_search) == "function" then
    pcall(_G.clear_search)
  else
    vim.fn.setreg("/", "")
    vim.cmd("nohlsearch")
  end
end)
