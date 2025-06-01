---@type NvPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local telescope = require('telescope')
    telescope.setup{
      defaults = {
        path_display = {"tail"},
        layout_strategy = "vertical"
      }
    }
  end
}
