return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function(_, opts)
    local luasnip = require "luasnip"
    luasnip.config.set_config(opts)

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath "config" .. "/vscode_snippets" } }
    -- Your own Lua snippets go in ~/.config/nvim/snippets/<filetype>.lua
    require("luasnip.loaders.from_lua").lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } }
  end,
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  },
}
