---@type NvPluginSpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = "<C-p>",
        },
      },
    })

    local suggestions_enabled = true
    local function set_suggestions_hidden(bufnr)
      vim.api.nvim_buf_set_var(bufnr, "copilot_suggestion_hidden", not suggestions_enabled)
    end

    local suggestions_group = vim.api.nvim_create_augroup("CopilotSuggestions", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = suggestions_group,
      callback = function(event)
        set_suggestions_hidden(event.buf)
      end,
    })

    vim.api.nvim_create_user_command("ToggleCopilotSuggestions", function()
      suggestions_enabled = not suggestions_enabled
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr) then
          set_suggestions_hidden(bufnr)
        end
      end
      vim.notify("Copilot suggestions " .. (suggestions_enabled and "enabled" or "disabled"))
    end, { desc = "Toggle Copilot suggestions" })
  end,
}
