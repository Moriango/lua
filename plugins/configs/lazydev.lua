---@type NvPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` field is found.
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
