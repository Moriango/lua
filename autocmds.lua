require "nvchad.autocmds"

local function remove_compile_helper_files_from_oldfiles()
  vim.v.oldfiles = vim.tbl_filter(function(path)
    local filename = vim.fn.fnamemodify(path, ":t")
    return filename ~= "input.txt" and filename ~= "output.txt"
  end, vim.v.oldfiles)
end

remove_compile_helper_files_from_oldfiles()

local yank_group = vim.api.nvim_create_augroup("SendYankToARegister", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    require("mappings")
    sendYankToARegister()
  end,
})

-- Compile and run the current C++ or C file.
_G.Compile_and_run_cpp = function()
  local filename = vim.fn.expand("%:p")
  local executable = vim.fn.fnamemodify(filename, ":r")
  local working_directory = vim.fn.getcwd()
  local output_file = working_directory .. "/output.txt"
  local input_file = working_directory .. "/input.txt"

  local valid_extensions = { "cpp", "c" }
  local valid_file = false
  for _, ext in ipairs(valid_extensions) do
    if filename:match("%." .. ext .. "$") then
      valid_file = true
      break
    end
  end

  if not valid_file then
    vim.notify("Not a valid C++ or C file.", vim.log.levels.WARN)
    return
  end

  local input_fd = io.open(input_file, "a")
  if input_fd == nil then
    vim.notify("Failed to open or create input file: " .. input_file, vim.log.levels.ERROR)
    return
  end
  input_fd:close()

  local output_fd = io.open(output_file, "w")
  if output_fd == nil then
    vim.notify("Failed to open or create output file: " .. output_file, vim.log.levels.ERROR)
    return
  end
  output_fd:close()

  local input_bufnr = vim.fn.bufnr(input_file)
  if input_bufnr == -1 then
    vim.cmd("vsp " .. vim.fn.fnameescape(input_file))
    input_bufnr = vim.api.nvim_get_current_buf()
  else
    vim.cmd(vim.fn.bufwinnr(input_bufnr) .. "wincmd w")
  end

  local output_bufnr = vim.fn.bufnr(output_file)
  if output_bufnr == -1 then
    vim.cmd("split " .. vim.fn.fnameescape(output_file))
    output_bufnr = vim.api.nvim_get_current_buf()
  else
    vim.cmd(vim.fn.bufwinnr(output_bufnr) .. "wincmd w")
  end

  vim.cmd("vertical resize 70%")

  local file = vim.fn.bufnr(filename)
  vim.cmd(vim.fn.bufwinnr(file) .. "wincmd w")

  local shellescape = vim.fn.shellescape
  local compile_cmd = string.format(
    "g++ %s -o %s && %s < %s > %s",
    shellescape(filename),
    shellescape(executable),
    shellescape(executable),
    shellescape(input_file),
    shellescape(output_file)
  )
  vim.cmd("silent w")
  vim.cmd("silent !clear")
  local command_output = vim.fn.system(compile_cmd)
  local exit_code = vim.v.shell_error

  if vim.api.nvim_buf_is_valid(output_bufnr) then
    vim.api.nvim_buf_call(output_bufnr, function()
      vim.cmd("edit!")
    end)
  end

  if exit_code ~= 0 then
    vim.notify(command_output ~= "" and command_output or "Compilation or program execution failed.", vim.log.levels.ERROR)
    return
  end

  vim.notify("Compiled and wrote output to " .. output_file, vim.log.levels.INFO)
  remove_compile_helper_files_from_oldfiles()
end

vim.api.nvim_create_user_command("CompileCpp", Compile_and_run_cpp, {
  desc = "Compile and run the current C++ or C file",
})

-- Show a notification when starting/stopping a macro recording
-- (native "recording @q" message is suppressed since 'showmode' is off)
local recording_group = vim.api.nvim_create_augroup("MacroRecordingNotify", { clear = true })

-- Notify when macro recording starts and show the register being recorded.
vim.api.nvim_create_autocmd("RecordingEnter", {
  group = recording_group,
  callback = function()
    vim.notify("Recording macro @" .. vim.fn.reg_recording(), vim.log.levels.INFO)
  end,
})

-- Notify when macro recording stops and show the register that was recorded.
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = recording_group,
  callback = function()
    vim.notify("Stopped recording macro @" .. vim.v.event.regname, vim.log.levels.INFO)
  end,
})

-- Rotate the buffers displayed in the current tab's regular split windows.
vim.api.nvim_create_user_command("RotateSplitScreens", function()
  local windows = {}

  for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local config = vim.api.nvim_win_get_config(window)
    if config.relative == "" then
      table.insert(windows, window)
    end
  end

  if #windows < 2 then
    vim.notify("Nothing to rotate", vim.log.levels.INFO)
    return
  end

  local buffers = {}
  for _, window in ipairs(windows) do
    table.insert(buffers, vim.api.nvim_win_get_buf(window))
  end

  table.insert(buffers, 1, table.remove(buffers))
  for index, window in ipairs(windows) do
    vim.api.nvim_win_set_buf(window, buffers[index])
  end
end, { desc = "Rotate buffers across all split windows" })

-- Replace the current buffer with a hidden buffer without closing the split.
vim.api.nvim_create_user_command("CloseBufferKeepSplit", function()
  local current_buffer = vim.api.nvim_get_current_buf()

  if vim.bo[current_buffer].modified then
    vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
    return
  end

  local visible_buffers = {}
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    visible_buffers[vim.api.nvim_win_get_buf(window)] = true
  end

  local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local replacement_buffer

  -- 1. Try to find a listed buffer that is not visible in any window
  for _, buffer in ipairs(listed_buffers) do
    if buffer.bufnr ~= current_buffer and not visible_buffers[buffer.bufnr] then
      replacement_buffer = buffer.bufnr
      break
    end
  end

  -- 2. If no hidden buffer exists, close the current window instead of
  -- displaying a buffer that is already visible in another split.
  if not replacement_buffer then
    if #vim.api.nvim_tabpage_list_wins(0) > 1 then
      vim.cmd("close")
      if vim.api.nvim_buf_is_valid(current_buffer) then
        pcall(vim.api.nvim_buf_delete, current_buffer, { force = true })
      end
    else
      vim.cmd("bdelete")
    end
    return
  end

  -- Replace the buffer across all windows that are currently displaying it
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(window) and vim.api.nvim_win_get_buf(window) == current_buffer then
      vim.api.nvim_win_set_buf(window, replacement_buffer)
    end
  end

  -- Safely delete the old buffer
  if vim.api.nvim_buf_is_valid(current_buffer) then
    pcall(vim.api.nvim_buf_delete, current_buffer, { force = true })
  end
end, { desc = "Close buffer and replace it with a hidden buffer" })

-- Toggle between Default and VSCode identifier highlights
local identifier_presets = {
  default = {
    Identifier = { fg = "#ffd166" },
    ["@variable"] = { fg = "#ffd166" },
    ["@variable.builtin"] = { fg = "#ff9f43" },
    ["@property"] = { fg = "#d6b7ff", italic = true },
    ["@type"] = { fg = "#86efac", bold = true },
    ["@type.builtin"] = { fg = "#4ade80" },
    ["@constant"] = { fg = "#f9a8d4", bold = true },
    ["@namespace"] = { fg = "#c4b5fd" },
  },
  vscode = {
    Identifier = { fg = "#D4D4D4" },
    ["@variable"] = { fg = "#9CDCFE" },
    ["@variable.builtin"] = { fg = "#569CD6" },
    ["@property"] = { fg = "#9CDCFE", italic = true },
    ["@type"] = { fg = "#4EC9B0", bold = true },
    ["@type.builtin"] = { fg = "#569CD6" },
    ["@constant"] = { fg = "#4FC1FF", bold = true },
    ["@namespace"] = { fg = "#4EC9B0" },
  },
}

local current_identifier_theme = "vscode"

vim.api.nvim_create_user_command("ToggleIdentifiers", function()
  if current_identifier_theme == "default" then
    current_identifier_theme = "vscode"
  else
    current_identifier_theme = "default"
  end

  local preset = identifier_presets[current_identifier_theme]
  for group, hl in pairs(preset) do
    vim.api.nvim_set_hl(0, group, hl)
  end

  local display_name = current_identifier_theme == "vscode" and "VSCode" or "Default"
  vim.notify("Identifier highlights: " .. display_name, vim.log.levels.INFO)
end, { desc = "Toggle between Default and VSCode identifier highlights" })

vim.api.nvim_create_user_command("DisableIdentifierColors", function()
  for group in pairs(identifier_presets.default) do
    vim.api.nvim_set_hl(0, group, {})
  end

  vim.notify("Identifier colors disabled", vim.log.levels.INFO)
end, { desc = "Disable custom identifier colors" })

-- Open a terminal in a horizontal split using the current working directory.
vim.api.nvim_create_user_command("SplitToTerminalHorizontally", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("split | resize 15 | terminal")
  vim.cmd("cd " .. cwd)
end, { desc = "Opens a terminal horizontally in current working directory" })

-- Open a terminal in a vertical split using the current working directory.
vim.api.nvim_create_user_command("SplitToTerminalVertically", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("vsplit | terminal")
  vim.cmd("cd " .. cwd)
end, { desc = "Opens a terminal vertically in current working directory" })

-- Select the entire current buffer and display a confirmation message.
vim.api.nvim_create_user_command("HighlightPage", function()
  vim.cmd("normal! ggVG")
  vim.cmd('echo "Entire buffer highlighted"')
end, { desc = "Highlight the entire page/buffer (select all)" })

-- Move the current line to the top of the visible window.
vim.api.nvim_create_user_command("MoveLineTop", function()
  vim.cmd("normal! zt")
end, { desc = "Move the current line to the top of the screen" })

-- Move the current line to the bottom of the visible window.
vim.api.nvim_create_user_command("MoveLineBottom", function()
  vim.cmd("normal! zb")
end, { desc = "Move the current line to the bottom of the screen" })

-- Toggle word wrapping for the current window.
vim.api.nvim_create_user_command("WordWrapToggle", function()
  vim.cmd("set wrap!")
  vim.cmd('echo "WordWrapToggle"')
end, { desc = "Toggle word wrap" })

-- Toggle the display of signs for marks in the current buffer.
vim.api.nvim_create_user_command("ToggleMarks", function()
  ---@diagnostic disable-next-line: undefined-field
  require("marks").toggle_signs()
end, { desc = "Toggle mark signs" })

-- Enable or disable Neovim diagnostic display.
vim.api.nvim_create_user_command("ToggleDiagnostic", function()
   if vim.diagnostic.is_enabled() then
   vim.diagnostic.enable(false)
   print("Diagnostics Disabled")
   else
     vim.diagnostic.enable()
     print("Diagnostics Enabled")
   end
end, { desc = "Toggles the diagnostic"})

-- Close all folds in the current buffer.
vim.api.nvim_create_user_command("FoldAllClose", function()
   vim.cmd("normal! zM")
end, { desc = "Closes all folds"})

-- Open all folds in the current buffer.
vim.api.nvim_create_user_command("FoldAllOpen", function()
 vim.cmd("normal! zR")
end, { desc = "Opens all folds"})

vim.api.nvim_create_user_command("ToggleLSP", function()
  local cmp = require('cmp')
  local current_state = cmp.get_config().enabled
  if current_state then
    cmp.setup.buffer { enabled = false }
    print("LSP and Autocompletions Disabled")
  else
    cmp.setup.buffer { enabled = true }
    print("LSP and Autocompletions Enabled")
  end
end, { desc = "Toggle LSP on and off" })

-- LSP symbol navigation: jump directly to functions, classes, or any symbol.
vim.api.nvim_create_user_command("PreviewFunctions", function()
    require("telescope.builtin").lsp_document_symbols({ symbols = { "function", "method" },}) end, { desc = "Go to function or method"}
)
vim.api.nvim_create_user_command("PreviewClass", function()
    require("telescope.builtin").lsp_document_symbols({ symbols = { "class", "struct", "interface", "namespace" },}) end, { desc = "Go to function or method"}
)

vim.api.nvim_create_user_command("ClearSearch", function()
  -- Clear the search state, notifications, highlights, and floating windows.
  vim.fn.setreg("/", "")
  vim.cmd("nohlsearch")
  vim.fn.clearmatches()

  local ok, notify = pcall(require, "notify")
  if ok and type(notify) == "table" and notify.dismiss then
    pcall(notify.dismiss)
  end

  for _, window in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(window) then
      local ok_config, config = pcall(vim.api.nvim_win_get_config, window)
      if ok_config and config and config.relative ~= "" then
        pcall(vim.api.nvim_win_close, window, true)
      end
    end
  end

  vim.cmd("redraw!")
  vim.notify("Search Cleared", vim.log.levels.INFO)
end, { desc = "Clear search state, notifications, and floating windows" })

-- Track the original Visual highlight while toggling its background.
local visual_bg_black = false
local original_visual_bg = nil

-- Toggle the background color of visual selections.
vim.api.nvim_create_user_command("ToggleVisualHighlight", function()
  if visual_bg_black then
    if original_visual_bg then
      vim.cmd("hi Visual guibg=" .. original_visual_bg)
    else
      vim.cmd("hi Visual guibg=NONE")
    end
    print("Visual background: Restored")
    visual_bg_black = false
  else
    local visual_hl = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
    if visual_hl.bg then
      original_visual_bg = string.format("#%06x", visual_hl.bg)
    end
    vim.cmd("hi Visual guibg=Black")
    print("Visual background: Black")
    visual_bg_black = true
  end
end, { desc = "Toggles the background in visual mode to black and default"})
-- Prevent invalid buffer errors when async LSP colorify responses arrive after a buffer is closed/deleted
local ok, colorify_utils = pcall(require, "nvchad.colorify.utils")
if ok and type(colorify_utils) == "table" and colorify_utils.needs_hl then
  local orig_needs_hl = colorify_utils.needs_hl
  colorify_utils.needs_hl = function(buf, ...)
    if not buf or not vim.api.nvim_buf_is_valid(buf) then
      return false
    end
    return orig_needs_hl(buf, ...)
  end
end
