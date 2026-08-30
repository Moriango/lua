require "nvchad.autocmds"

-- Show a notification when starting/stopping a macro recording
-- (native "recording @q" message is suppressed since 'showmode' is off)
local recording_group = vim.api.nvim_create_augroup("MacroRecordingNotify", { clear = true })

vim.api.nvim_create_autocmd("RecordingEnter", {
  group = recording_group,
  callback = function()
    vim.notify("Recording macro @" .. vim.fn.reg_recording(), vim.log.levels.INFO)
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  group = recording_group,
  callback = function()
    vim.notify("Stopped recording macro @" .. vim.v.event.regname, vim.log.levels.INFO)
  end,
})
