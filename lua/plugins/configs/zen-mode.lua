---@type NvPluginSpec
return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  cmd = "ZenMode",
  init = function()
    local map = vim.keymap.set
    map("n", "<leader>kz", "<cmd>ZenMode<CR>", { desc = "Toggles ZenMode"})

    -- Function to toggle Twilight
    local twilight_enabled = true
    function ToggleTwilight()
      twilight_enabled = not twilight_enabled
      if twilight_enabled then
        require("twilight").enable()
        print("Twilight enabled")
      else
        require("twilight").disable()
        print("Twilight disabled")
      end
    end

    -- Create a command to toggle Twilight
    vim.api.nvim_create_user_command("ToggleTwilight", ToggleTwilight, {})

    -- Optionally, create a keybinding to toggle Twilight
    map("n", "kt", ":Twilight<CR>", { desc = "Toggles Twilight", noremap = true, silent = true })
  end,
  config = function()
  end,
}
