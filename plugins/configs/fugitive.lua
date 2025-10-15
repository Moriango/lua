-- plugins/git.lua
return {
  "tpope/vim-fugitive",
  cmd = {
    "Git",
    "G",
    "Gstatus",
    "Gcommit",
    "Gpush",
    "Gpull",
    "Gdiff",
    "Gblame",
    "Glog",
    "Gwrite",
    "Gread"
  },
  config = function()
    -- Ensure vim-fugitive commands are available
    vim.api.nvim_create_user_command('Gstatus', 'Git status', {})
    vim.api.nvim_create_user_command('Gs', 'Git status', {})
  end,
}
