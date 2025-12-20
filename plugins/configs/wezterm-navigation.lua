---@type NvPluginSpec
return {
    "letieu/wezterm-move.nvim",
    lazy = false, -- Load on startup so commands are available
    priority = 1000, -- Load early to set keymaps before other plugins
    config = function()
      local wez = require("wezterm-move")
      
      -- Set up keymaps for navigation (Ctrl + hjkl)
      vim.keymap.set("n", "<C-h>", function() wez.move("h") end, { noremap = true, silent = true, desc = "Move left (Nvim/WezTerm)" })
      vim.keymap.set("n", "<C-j>", function() wez.move("j") end, { noremap = true, silent = true, desc = "Move down (Nvim/WezTerm)" })
      vim.keymap.set("n", "<C-k>", function() wez.move("k") end, { noremap = true, silent = true, desc = "Move up (Nvim/WezTerm)" })
      vim.keymap.set("n", "<C-l>", function() wez.move("l") end, { noremap = true, silent = true, desc = "Move right (Nvim/WezTerm)" })
      
      -- Create command-mode commands for navigation
      vim.api.nvim_create_user_command("WezLeft", function()
        wez.move("h")
      end, { desc = "Navigate to left pane (WezTerm/Nvim)" })

      vim.api.nvim_create_user_command("WezDown", function()
        wez.move("j")
      end, { desc = "Navigate to pane below (WezTerm/Nvim)" })

      vim.api.nvim_create_user_command("WezUp", function()
        wez.move("k")
      end, { desc = "Navigate to pane above (WezTerm/Nvim)" })

      vim.api.nvim_create_user_command("WezRight", function()
        wez.move("l")
      end, { desc = "Navigate to right pane (WezTerm/Nvim)" })
    end,
}
