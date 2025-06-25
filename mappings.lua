require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = false, silent = false}

-- FullScreen
map("n", "<leader>m", ":only<CR>", { desc = "Makes the current split screen fullscreen"})

-- Toggle Transparency
map("n", "<leader>tp", ":lua require('base46').toggle_transparency()<CR>", { noremap = true, silent = true, desc = "Toggle Background Transparency" })
-- Exiting
map("n", ";", ":", { desc = "CMD enter command mode" })
map({"n","i","v"}, "jk", "<ESC>")
map("t", "<Esc>",[[<C-\><C-n>]], { desc = "Exit from terminal mode"})
map("t", "jk",[[<C-\><C-n>]], { desc = "Exit from terminal mode"})

-- File Tree 
map({"n","i","v"}, "<leader>ee", ":NvimTreeToggle<CR>", { desc = "Toggles the file tree", noremap = true, silent=true })
map("n", "<leader>zz", ":NvimTreeCollapse<CR>",{ noremap = true, silent = true, desc = "Closes File Tree"} )

-- Moving Horizontaly
map({"n","v"}, "ee", "$", { desc = "Move cursor to the end of the current line", noremap = true, silent=true })
map({"n","v"}, "ba", "^", { desc = "Move cursor to the begginning of the current line", noremap = true, silent=true })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves the current line up", noremap = true, silent=true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves the current line up", noremap = true, silent=true })

-- Lazy Git
map({"n","i"}, "<leader>lz", ":Lazy<CR>", { desc = "Opens Lazy"})

-- Moving Vertically
map({"n","i"}, "<C-d>", "<C-d>zz", { desc = "Moves the cursor down half a page and centers it.", noremap = true, silent=true })
map({"n","i"}, "<C-u>", "<C-u>zz", { desc = "Moves the cursor up half a page and centers it.", noremap = true, silent=true })
map("n", "G", "Gzz", { desc = "Moves the cursor to the bottom of the page and centers the screen", noremap = true, silent=true })
map("n", "gg", "ggzz", { desc = "Moves the cursor to the top of the page and centers the screen", noremap = true, silent=true })

-- Tabs
map("n", "<leader>tt", ":tabnew | lcd %:p:h<CR>", { desc = "Opens a new tab", noremap = true, silent=true })
map("n", "<A-Tab>", ":tabnext <CR>", { desc = "Switches tab", noremap = true, silent=true })
map("n", "<A-S-Tab>", ":tabprevious <CR>", { desc = "Switches tab", noremap = true, silent=true })

-- Buffers
map("n", "<leader>c", ":close<CR>", { desc = "Closes the current split window", noremap = true, silent=true })
map("n", "sv", ":split<Return>", { desc = "Splits tab Horizontally", noremap = true, silent=true })
map("n", "sh", ":vsplit<CR>", { desc = "Splits tab Vertically", noremap = true, silent=true })
map("n", "<leader>x", "<C-w>c", { noremap=true, silent=true})
map("n", "<leader>q", ":bd!<CR>", { noremap=true, silent=true})
map("n", "<leader>bb", "<C-w><C-r>", {noremap=true, silent=true})

-- Resize window
map("n", "<A-h>", ":vertical resize -2<Return>", { noremap=true, silent=true })
map("n", "<A-j>", ":resize -2<Return>", { noremap=true, silent=true })
map("n", "<A-k>", ":resize +2<Return>", { noremap=true, silent=true})
map("n", "<A-l>", ":vertical resize +2<Return>", { noremap=true, silent=true})

-- Terminal
map("n", "<leader>tm", ":split | resize 15 |terminal<CR>", { desc = "Opens a terminal Horizontally"})
map("n", "st", ":vsplit | terminal<CR>", { desc = "Opens a terminal Vertically"})

-- Searching
map("n", "caw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor globally"})
map("n", "cwi", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], { desc = "Replace word under cursor globally and ask"})
-- Smart search function that checks if current word is already being searched
function smart_search(direction)
  local current_word = vim.fn.expand("<cword>")
  local search_word = vim.fn.getreg("/")
  
  -- Check if there's an active search
  if search_word == "" then
    -- No active search, start a new one with case sensitivity
    clear_search()
    local word = vim.fn.escape(current_word, "\\[].*~")
    vim.fn.setreg("/", "\\C\\<" .. word .. "\\>")
    vim.cmd("normal! n")
    print("Searching: ", word)
    return
  end
  
  -- Check if this was a manual search (doesn't have word boundary markers)
  local is_manual_search = not search_word:match("^\\<.*\\>$")
  if is_manual_search then
    if direction == "next" then
      vim.cmd("normal! n")
      print("Searching: ", search_word)
    else
      vim.cmd("normal! N")
      print("Searching: ", search_word)
    end
  else
    -- For word searches, check if it's the current word
    clear_search()
    local clean_search_word = search_word:gsub("\\<", ""):gsub("\\>", "")
    
    if clean_search_word == current_word then
      -- Continue searching the current word
      if direction == "next" then
        vim.cmd("normal! n")
        print("Searching: ", search_word)
      else
        vim.cmd("normal! N")
        print("Searching: ", search_word)
      end
    else
      -- Search for the new word under cursor
      vim.cmd("normal! *")
      print("Searching: ", search_word)
    end
  end
end

map("n", "n", ":lua smart_search('next')<CR>", {desc = "Smart search next", noremap = true, silent = true})
map("n", "N", ":lua smart_search('prev')<CR>", {desc = "Smart search previous", noremap = true, silent = true})

-- Clear search highlighting and pattern
function clear_search()
  vim.fn.setreg("/", "")
  vim.cmd("nohlsearch")
end

map("n", "ff", ":lua clear_search()<CR>", { desc = "Clear search pattern and highlight", silent=true})

-- Project
map("n", "cd", "<cmd>CdProject<CR>", { desc = "Cd Project, Change working directory"})
map("n", "cda", "<cmd>CdProjectAdd<CR>", { desc = "Cd Project, add current project's directory to the databse(json file)"})
map("n", "cdm", "<cmd>CdProjectManualAdd<CR>", { desc = "Cd Project, Manually add project's directory to the databse(json file)"})

-- Diagnostics
map('n', 'td', function()
vim.diagnostic.enable(not vim.diagnostic.is_enabled())
if vim.diagnostic.is_enabled() then
  print("Diagnostics Enabled")
else
  print("Diagnostics Disabled")
end
end, { silent = true, noremap = true })

-- Mark Navigamtion
map("n", "nm", "]'", { desc = "Jump to next mark", noremap = true, silent = true })
map("n", "pm", "['", { desc = "Jump to previous mark", noremap = true, silent = true })

-- Indent
map("n", "t", ">>", { noremap = true, silent=true })
map("n", "T", "<<", { noremap = true, silent=true })
map("v", "t", ">gv", { noremap = true, silent=true })
map("v", "T", "<gv", { noremap = true, silent=true })

-- Deleting
map("n", "de", "D", opts)
map("n", "db", "d0", opts)

-- Open terminal with Ipython
map("n", "<leader>p", ":vsplit | terminal ipython<CR>", { desc = "Open a terminal with Ipython", noremap=true, silent=true})

-- Registers
map("n", "rr", ":reg<CR>")

-- Function to toggle cmp for the current buffer
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

-- Key mapping to toggle cmp
vim.api.nvim_set_keymap('n', 'tl', ':lua toggle_lsp()<CR>', { noremap = true, silent = true })

-- Scroll through preious input/commands in the terminal using Tab key
map("t", "<C-k>", "<UP>", { noremap = true, silent=true, desc = "Scroll up through previous inputs/commands"})
map("t", "<C-j>", "<DOWN>", { noremap = true, silent=true, desc = "Scroll down through previous inputs/commands"})
map("t", "<C-l>", "<Right>", { noremap = true, silent=true, desc = "Autocompletes in terminal mode"})

-- Simulate middle click
-- Will not work in dev-desktop
map({"n","i","t"}, "<leader>mm", '"+p', { noremap = true, silent=true, desc = "Simulate the middle click on the mouse"})

-- Open current working directory in VS Code
-- Will not work in dev-desktop

-- Open current working directory in VS Code
map("n", "vv", ":silent !code .<CR>", { noremap = true, silent = true, desc = "Opens current working directory in VS Code" })

-- Delete Buffer
function close_nvim_tree_and_buffer()
local nvim_tree_api = require('nvim-tree.api')
if nvim_tree_api.tree.is_visible() then
  vim.cmd('wincmd l')
  nvim_tree_api.tree.close()
end
vim.cmd('bd!')
end
map({"n","t",}, "qq", ":lua close_nvim_tree_and_buffer()<CR>", { noremap = true, silent = true, desc = "Deletes/Closes buffer window"})

-- Git Blame Toggle 
map("n", "gb", ":silent GitBlameToggle<CR>:echom 'Git Blame Toggle'<CR>", { desc = "Toggles GitBlame", noremap = true })

-- Refresh current Burrer
function refresh_buffer()
print("Refreshed Buffer")
vim.cmd('edit')
end
map("n", "<leader>rb", ":lua refresh_buffer()<CR>",{ noremap = true, silent = true, desc = "Refreshes Current Buffer"})

map("n", "<C-A>", "ggVG", { noremap = true, silent = true, desc = "Highligts the entire buffer."})

map("n", "<leader>qa", ":qa!<CR>",{ noremap = true, silent = true, desc = "Closes All Buffers"} )

-- Amazon Q 
map("n", "<leader>al", function()
    -- Start Amazon Q LSP
    vim.lsp.start(require('amazonq.lsp').config)
    -- Wait for 1 second
    vim.defer_fn(function()
        -- Execute login command
        vim.cmd("AmazonQ login")
        vim.notify("Logged in to Amazon Q")
    end, 1000)  -- 1000ms = 1 second
end, { noremap = true, silent = true, desc = "Start Amazon Q LSP and Login" })

map("n", "<leader>af", ":.AmazonQ fix<CR>:echom 'Fixing current line'<CR>", { noremap = true, silent = true, desc = "Fix only the  current line"} )
map("n", "<leader>ao", ":%AmazonQ fix<CR>:echom 'Optimizing the file.'<CR>", { noremap = true, silent = true, desc = "Optimize the entire content of the file"} )
map("n", "<leader>ae", ":AmazonQ explain<CR>:echom 'Eplaining File'<CR>", { noremap = true, silent = true, desc = "Explain the current file"} )
map("n", "ZZ", ":AmazonQ toggle<CR>:echom 'Toggling AmazonQ'<CR>", { noremap = true, silent = true, desc = "Toggles Amazon Q chat"} )

map("n", "cn", ":cnext<CR>", { noremap = true, silent = true, desc = "Go to next item in quickfix list"})
map("n", "cp", ":cprev<CR>", { noremap = true, silent = true, desc = "Go to previous item in quickfix list"})
map("n", "CC", ":cclose<CR>", { noremap = true, silent = true, desc = "Close the quickfix list"})

map("n", "yp", function()
    -- Save current directory
    local current_dir = vim.fn.getcwd()
    -- Enable autochdir temporarily
    vim.cmd("set autochdir")
    -- Get the URL and open it based on system
    if vim.fn.has("mac") == 1 then
        vim.cmd("GBrowse")
    else
        vim.cmd("GBrowse!")
    end
    -- Return to original directory
    vim.cmd("cd " .. current_dir)
end, { desc = "Open file in AWS Code Browser" })

-- Copy filename to clipboard
map("n", "yn", function()
   local filename = vim.fn.expand("%:t")
    vim.fn.setreg('+', filename)
    vim.fn.setreg('*', filename)
    vim.fn.setreg('"', filename)
    print("Filename '" .. filename .. "' copied to clipboard")
end, { desc = "Copy filename to clipboard" })

-- Copy full file path to clipboard
map("n", "yfp", function()
    local filepath = vim.fn.expand("%:p:h")
    vim.fn.setreg('+', filepath)
    vim.fn.setreg('*', filepath)
    vim.fn.setreg('"', filepath)
    print("File path '" .. filepath .. "' copied to clipboard")
end, { desc = "Copy full file path to clipboard" })

vim.keymap.set('n', 'bc', function()
    print('Buffer count: ' .. #vim.fn.getbufinfo({buflisted=1}))
end)

-- Count files in current directory
map("n", "<leader>cf", function()
    local handle = io.popen('find . -maxdepth 1 -type f | wc -l')
    if handle then
        local result = handle:read("*a")
        handle:close()
        -- Remove trailing whitespace/newlines and convert to number
        result = tonumber(result:match("^%s*(.-)%s*$"))
        print("Files in current directory: " .. result)
    else
        print("Error counting files")
    end
end, { desc = "Count files in current directory", noremap = true })

map("n", "MM", function()
  vim.cmd("set autochdir")
  vim.cmd("set noautochdir")
  local cwd = vim.fn.getcwd()
  print("Changed Directories: " .. cwd)
  end, { desc = "Autochdir setting", noremap = true })

map("n", "_", function()
  vim.cmd("cd ../")
  local cwd = vim.fn.getcwd()
  print("Current directory: " .. cwd)
  end, { desc = "Moving working directory up one level", noremap = true })
