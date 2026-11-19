---@type NvPluginSpec
return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  cmd = "ZenMode",
  opts = {
    plugins = {
      twilight = { enabled = true },
      gitsigns = { enabled = false },
      todo = { enabled = false },
      tmux = { enabled = true },
    },
  },
  init = function()
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
  end,
}
