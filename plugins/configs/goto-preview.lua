---@type NvPluginSpec
return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  config = function()
    require('goto-preview').setup {
      width = 120; -- Width of the floating window
      height = 25; -- Height of the floating window
      border = {"↖", "─" ,"┐", "│" ,"┘", "─", "└", "│"}; -- Border characters
      default_mappings = true; -- Bind default mappings
      debug = false; -- Print debug information
      opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
      resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
      post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
      references = { -- Configure the telescope UI for handling references
        telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
      };
      focus_on_open = true; -- Focus the floating window when opening it.
      dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
      force_close = true, -- Force close the floating window when it loses focus.
      bufhidden = "wipe", -- The bufhidden option to set on the floating window. See `:h bufhidden`
    }

    -- Optional: Set up custom key mappings
    vim.api.nvim_set_keymap('n', 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'px', "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true, silent = true })
  end,
}
