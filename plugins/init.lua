local plugins = {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      local config = require "nvchad.configs.nvimtree"
      config.filters = config.filters or {}
      config.filters.custom = config.filters.custom or {}
      table.insert(config.filters.custom, "__pycache__")

      --This is to change the side of of the nvim tree
      -- config.view = config.view or {}
      -- config.view.side = "left"
      -- return config
    end,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc", 
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {import = "plugins.configs.zen-mode"},
  {import = "plugins.configs.diffview"},
  {import = "plugins.configs.vim-illuminate"},
  {import = "plugins.configs.cd-project"},
  {import = "plugins.configs.lsp-signature"},
  {import = "plugins.configs.markview"},
  {import = "plugins.configs.md-preview"},
  {import = "plugins.configs.hover"},
  {import = "plugins.configs.screenkey"},
  {import = "plugins.configs.undotree"},
  {import = "plugins.configs.which-key"},
  {import = "plugins.configs.live-server"},
  {import = "plugins.configs.vim-tmux-navigator"},
  {import = "plugins.configs.marks"},
  {import = "plugins.configs.mini_surround"},
  {import = "plugins.configs.lazygit"},
  {import = "plugins.configs.gitblame"},
  {import = "plugins.configs.goto-preview"},
  {import = "plugins.configs.copilot"},
  {import = "plugins.configs.chat"},
}
return plugins

