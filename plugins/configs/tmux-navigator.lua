---@type NvPluginSpec
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },

  config = function()
    -- Delete existing keymaps first to avoid conflicts
    vim.keymap.del("n", "<C-h>", { silent = true })
    vim.keymap.del("n", "<C-j>", { silent = true })
    vim.keymap.del("n", "<C-k>", { silent = true })
    vim.keymap.del("n", "<C-l>", { silent = true })
    
    -- Set up keymaps for navigation (Ctrl + hjkl)
    vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Move left" })
    vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Move down" })
    vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Move up" })
    vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Move right" })
  end,
}
