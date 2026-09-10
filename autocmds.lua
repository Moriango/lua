require "nvchad.autocmds"

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

  local replacement_buffer
  for _, buffer in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if buffer.bufnr ~= current_buffer and not visible_buffers[buffer.bufnr] then
      replacement_buffer = buffer.bufnr
      break
    end
  end

  if not replacement_buffer then
    vim.cmd("bdelete")
    return
  end

  vim.api.nvim_set_current_buf(replacement_buffer)
  vim.api.nvim_buf_delete(current_buffer, {})
end, { desc = "Close buffer and replace it with a hidden buffer" })

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

-- Separate yank from delete by sending all yanks to register 'a'
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Save yanks to register a',
  callback = function()
    -- Only trigger if the user performed a genuine yank (not a delete/change)
    if vim.v.event.operator == 'y' then
      vim.fn.setreg('a', vim.fn.getreg('"'))
      print("Yanked Lines")
    end
  end,
})
