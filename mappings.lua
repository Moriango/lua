require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = false, silent = false}

-- MAPPINGS --

-- Window shortcuts: change layouts, create splits, close windows, and rotate buffers.
map("n", "<leader>m", ":only<CR>", { desc = "Makes the current split screen fullscreen"})

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

-- Page movement shortcuts: move by pages or jump to the top and bottom of a buffer.
map({"n"}, "D", "<C-d>zz", { desc = "Moves the cursor down half a page and centers it.", noremap = true, silent=true })
map({"n"}, "U", "<C-u>zz", { desc = "Moves the cursor up half a page and centers it.", noremap = true, silent=true })
map("n", "G", "Gzz", { desc = "Moves the cursor to the bottom of the page and centers the screen", noremap = true, silent=true })
map("n", "gg", "ggzz", { desc = "Moves the cursor to the top of the page and centers the screen", noremap = true, silent=true })

-- Window and buffer shortcuts: create, close, rotate, and switch split windows or buffers.
map("n", "sv", ":split<Return>", { desc = "Splits tab Horizontally", noremap = true, silent=true })
map("n", "sh", ":vsplit<CR>", { desc = "Splits tab Vertically", noremap = true, silent=true })
map("n", "<leader>x", "<C-w>c", { desc =  "Closes the current split window", noremap=true, silent=true})
map("n", "<leader>q", ":bd!<CR>", { noremap=true, silent=true})
map("n", ",", "<cmd>RotateSplitScreens<CR>", { noremap = true, silent = true, desc = "Rotate all split screens" })

-- Terminal shortcuts: open a shell in a vertical split.
map("n", "<leader>ts", "<cmd>SplitToTerminalVertically<CR>", { desc = "Opens a terminal Vertically in current working directory"})

-- Search shortcuts: search intelligently, replace the word under the cursor, and rename symbols.
map("n", "n", ":lua smart_search('next')<CR>", {desc = "Smart search next", noremap = true, silent = true})
map("n", "N", ":lua smart_search('prev')<CR>", {desc = "Smart search previous", noremap = true, silent = true})

-- Replace words
map("n", "<leader>cw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], { desc = "Replace word under cursor globally and ask"})
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "LSP: Rename"})

-- Clear search results
map("n", "ff", ":lua clear_search()<CR>", { desc = "Clear search pattern and highlight", silent=true})

-- Project shortcuts: change to a project and add project directories to the project database.
map("n", "cd", "<cmd>CdProject<CR>", { desc = "Cd Project, Change working directory"})
map("n", "cda", "<cmd>CdProjectAdd<CR>", { desc = "Cd Project, add current project's directory to the databse(json file)"})
map("n", "cdm", "<cmd>CdProjectManualAdd<CR>", { desc = "Cd Project, Manually add project's directory to the databse(json file)"})

-- Diagnostic jumps notify when the list wraps around.
map("n", "]d", ":lua diagnostic_jump('next')<CR>", { desc = "Go to next diagnostic", noremap = true, silent = true })
map("n", "[d", ":lua diagnostic_jump('prev')<CR>", { desc = "Go to previous diagnostic", noremap = true, silent = true })

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

-- History and register shortcuts: navigate the change list and inspect registers.
map("n", ">>", "g;", { noremap = true, silent = true, desc = "Go to next edit"} )
map("n", "<<", "g,", { noremap = true, silent = true, desc = "Go to previous edit"} )

-- Python shortcut: open an IPython terminal in a vertical split.
map("n", "<leader>p", ":vsplit | terminal ipython<CR>", { desc = "Open a terminal with Ipython", noremap=true, silent=true})

map("n", "rr", ":reg<CR>")

-- Completion and LSP shortcuts: toggle completion and rename the symbol under the cursor.
vim.api.nvim_set_keymap('n', '<leader>tl', ':lua toggle_lsp()<CR>', { noremap = true, silent = true })

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
map("n", "gb", ":silent GitBlameToggle<CR>:echom 'Git Blame Toggle'<CR>", { desc = "Toggles GitBlame", noremap = true })
map("n", "[g", ":lua gitsigns_preview()<CR>", { desc = "Opens git signs and jumps to next hunk", noremap = true})
map("n", "]g", ":lua gitsigns_previous_hunk()<CR>", { desc = "Jump to previous hunk and center", noremap = true, silent = true })

-- Buffer and workspace utility shortcuts: select the whole buffer and count buffers.
map("n", "<leader>h", "<cmd>HighlightPage<CR>", { noremap = true, silent = true, desc = "Highlight the entire buffer"})

-- Quickfix shortcuts: navigate through and close the quickfix list.
map("n", "]c", ":cnext<CR>", { noremap = true, silent = true, desc = "Go to next item in quickfix list"})
map("n", "[c", ":cprev<CR>", { noremap = true, silent = true, desc = "Go to previous item in quickfix list"})
map("n", "CC", ":cclose<CR>", { noremap = true, silent = true, desc = "Close the quickfix list"})

-- File information shortcuts: copy the current filename, full filename, or directory path.
map("n", "yn", ":lua copy_filename_without_extension()<CR>", { desc = "Copy filename to clipboard" })
map("n", "yfn", ":lua copy_filename()<CR>", { desc = "Copy filename to clipboard" })
map("n", "yp", ":lua copy_file_directory()<CR>", { desc = "Copy full file path to clipboard" })

-- Buffer count shortcut: report the number of listed buffers.
map("n", "bc", ":lua print_buffer_count()<CR>")

-- Directory shortcuts: count files, show the working directory, and move to its parent.
map("n", "fc", ":lua count_files_in_directory()<CR>", { desc = "Count files in current directory", noremap = true })
map("n", "MM", ":lua change_current_directory()<CR>", { desc = "Autochdir setting", noremap = true })
map("n", "_", ":lua move_to_parent_directory()<CR>", { desc = "Moving working directory up one level", noremap = true })
-- Visual selection shortcuts: toggle the visual selection background color.
map({"n","v",}, "<leader>tv", ":lua toggle_visual_bg()<CR>", { noremap = true, silent = true, desc = "Toggle visual selection background" })

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

-- Prompt for and delete one mark.
function delete_mark()
  vim.ui.input({ prompt = "Delete mark: " }, function(mark)
    if not mark or mark == "" then
      return
    end

    if not mark:match("^[A-Za-z]$") then
      vim.notify("Enter one letter mark", vim.log.levels.WARN)
      return
    end

    require("marks").mark_state:delete_mark(mark)
  end)
end

-- Delete every mark in the current buffer.
function delete_all_marks()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z")
  require("marks").refresh(true)
end

-- Search for the word under the cursor and move to the next or previous match.
function smart_search(direction)
  local cursor_word = vim.fn.expand("<cword>")
  local search_register = vim.fn.getreg("/")
  local last_smart_search = vim.g.last_smart_search or ""
  local move_cmd = (direction == "next") and "normal! n" or "normal! N"

  if search_register ~= "" and search_register ~= last_smart_search then
    vim.cmd(move_cmd)
    return
  end

  local escaped = vim.fn.escape(cursor_word, "\\[].*~")
  local pattern = "\\C\\<" .. escaped .. "\\>"
  vim.fn.setreg("/", pattern)
  vim.g.last_smart_search = pattern
  vim.cmd(move_cmd)
end

-- Clear the search state, notifications, highlights, and floating windows.
function clear_search()
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

-- Move to the next or previous diagnostic and show it in a floating window.
function diagnostic_jump(direction)
  local target = direction == "next" and vim.diagnostic.get_next({}) or vim.diagnostic.get_prev({})
  if not target then
    vim.notify("No more " .. direction .. " diagnostics, wrapping around", vim.log.levels.WARN)
  end
  if direction == "next" then
    vim.diagnostic.jump({ count = 1, float = true })
  else
    vim.diagnostic.jump({ count = -1, float = true })
  end
end

-- Enable or disable completion for the current buffer.
function toggle_lsp()
  local cmp = require('cmp')
  local current_state = cmp.get_config().enabled
  if current_state then
    cmp.setup.buffer { enabled = false }
    print("LSP and Autocompletions Disabled")
  else
    cmp.setup.buffer { enabled = true }
    print("LSP and Autocompletions Enabled")
  end
end

-- Close the file tree and delete the current buffer.
function close_nvim_tree_and_buffer()
  local nvim_tree_api = require('nvim-tree.api')
  if nvim_tree_api.tree.is_visible() then
    vim.cmd('wincmd l')
    nvim_tree_api.tree.close()
  end
  vim.cmd('bd!')
end

-- Reload the current buffer from disk.
function refresh_buffer()
  print("Refreshed Buffer")
  vim.cmd('edit')
end

-- Copy a value to the system clipboards and report what was copied.
local function copy_to_clipboard(value, label)
  vim.fn.setreg('+', value)
  vim.fn.setreg('*', value)
  vim.fn.setreg('"', value)
  print(label .. " '" .. value .. "' copied to clipboard")
end

-- Copy the current filename without its extension.
function copy_filename_without_extension()
  copy_to_clipboard(vim.fn.expand("%:t:r"), "Filename")
end

-- Copy the current filename with its extension.
function copy_filename()
  copy_to_clipboard(vim.fn.expand("%:t"), "Filename")
end

-- Copy the directory containing the current file.
function copy_file_directory()
  copy_to_clipboard(vim.fn.expand("%:p:h"), "File path")
end

-- Print the number of listed buffers.
function print_buffer_count()
  print('Buffer count: ' .. #vim.fn.getbufinfo({buflisted=1}))
end

-- Count regular files in the current directory.
function count_files_in_directory()
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
function change_current_directory()
  vim.cmd("set autochdir")
  vim.cmd("set noautochdir")
  print("Changed Directories: " .. vim.fn.getcwd())
end

-- Change to the parent of the current working directory.
function move_to_parent_directory()
  vim.cmd("cd ../")
  print("Current directory: " .. vim.fn.getcwd())
end

-- Track the original Visual highlight while toggling its background.
local visual_bg_black = false
local original_visual_bg = nil

-- Toggle the background color of visual selections.
function toggle_visual_bg()
  if visual_bg_black then
    if original_visual_bg then
      vim.cmd("hi Visual guibg=" .. original_visual_bg)
    else
      vim.cmd("hi Visual guibg=NONE")
    end
    print("Visual background: Restored")
    visual_bg_black = false
  else
    local visual_hl = vim.api.nvim_get_hl_by_name('Visual', true)
    if visual_hl.background then
      original_visual_bg = string.format("#%06x", visual_hl.background)
    end
    vim.cmd("hi Visual guibg=Black")
    print("Visual background: Black")
    visual_bg_black = true
  end
end

-- Enable or disable diagnostics for the current Neovim session.
function toggle_diagnostic()
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

function gitsigns_preview()
  gitsigns_restore_main_win()
  require("gitsigns").next_hunk({}, function()
    vim.cmd("normal! zz")
    require("gitsigns").preview_hunk()
  end)
end

function gitsigns_previous_hunk()
  gitsigns_restore_main_win()
  require("gitsigns").prev_hunk({}, function()
    vim.cmd("normal! zz")
    require("gitsigns").preview_hunk()
  end)
end

vim.schedule(function()
  require("commands").setup()
  require "mappings"
  if type(_G.clear_search) == "function" then
    pcall(_G.clear_search)
  else
    vim.fn.setreg("/", "")
    vim.cmd("nohlsearch")
  end
end)

