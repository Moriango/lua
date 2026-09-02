local M = {}

function M.setup()
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

  vim.api.nvim_create_user_command("SplitToTerminalHorizontally", function()
    local cwd = vim.fn.getcwd()
    vim.cmd("split | resize 15 | terminal")
    vim.cmd("cd " .. cwd)
  end, { desc = "Opens a terminal horizontally in current working directory" })

  vim.api.nvim_create_user_command("SplitToTerminalVertically", function()
    local cwd = vim.fn.getcwd()
    vim.cmd("vsplit | terminal")
    vim.cmd("cd " .. cwd)
  end, { desc = "Opens a terminal vertically in current working directory" })

  vim.api.nvim_create_user_command("HighlightPage", function()
    vim.cmd("normal! ggVG")
    vim.cmd('echo "Entire buffer highlighted"')
  end, { desc = "Highlight the entire page/buffer (select all)" })

  vim.api.nvim_create_user_command("WordWrapToggle", function()
    vim.cmd("set wrap!")
    vim.cmd('echo "WordWrapToggle"')
  end, { desc = "Toggle word wrap" })

  vim.api.nvim_create_user_command("ToggleMarks", function()
    require("marks").toggle_signs()
  end, { desc = "Toggle mark signs" })
end

vim.api.nvim_create_user_command("ToggleDiagnostic", function()
    if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    print("Diagnostics Disabled")
    else
      vim.diagnostic.enable()
      print("Diagnostics Enabled")
    end
end, { desc = "Toggles the diagnostic"})

return M
