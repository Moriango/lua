local plugins = {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
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
      -- config.view = config.view or {} config.view.side = "left"
      -- return config
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display={"absolute"},
        file_ignore_patterns = { "^%.git/", "/%.git/" },
        layout_strategy="vertical",
        layout_config = {
          vertical = {
            prompt_position = "top",
            preview_cutoff = 0,
            mirror = true,
            preview_height = 0.6
          }
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
    config = function(PluginSpec,opts)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      local function open_all_selected(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()
        
        actions.close(prompt_bufnr)
        
        if #selections > 0 then
          for _, selection in ipairs(selections) do
            vim.cmd("edit " .. selection.value)
          end
        else
          local entry = action_state.get_selected_entry()
          if entry then
            vim.cmd("edit " .. entry.value)
          end
        end
      end
      
      local function send_to_quickfix(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()
        
        if #selections > 0 then
          actions.send_selected_to_qflist(prompt_bufnr)
        else
          actions.send_to_qflist(prompt_bufnr)
        end
        actions.open_qflist(prompt_bufnr)
      end
      
      opts.pickers.oldfiles = opts.pickers.oldfiles or {}
      opts.pickers.oldfiles.mappings = {
        i = {
          ["<CR>"] = open_all_selected,
          ["<C-q>"] = send_to_quickfix,
        },
        n = {
          ["<CR>"] = open_all_selected,
          ["<C-q>"] = send_to_quickfix,
        },
      }
      
      opts.pickers.find_files = opts.pickers.find_files or {}
      opts.pickers.find_files.mappings = {
        i = {
          ["<CR>"] = open_all_selected,
          ["<C-q>"] = send_to_quickfix,
        },
        n = {
          ["<CR>"] = open_all_selected,
          ["<C-q>"] = send_to_quickfix,
        },
      }
      
      opts.pickers.live_grep = opts.pickers.live_grep or {}
      opts.pickers.live_grep.mappings = {
        i = {
          ["<C-q>"] = send_to_quickfix,
        },
        n = {
          ["<C-q>"] = send_to_quickfix,
        },
      }
      
      opts.pickers.grep_string = opts.pickers.grep_string or {}
      opts.pickers.grep_string.mappings = {
        i = {
          ["<C-q>"] = send_to_quickfix,
        },
        n = {
          ["<C-q>"] = send_to_quickfix,
        },
      }
      
      require('telescope').setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {"all", "yaml"},
      highlight = {
          enable = true,
      },
    },
  {import = "plugins.configs.copilot"},
  -- {import = "plugins.configs.diff"},
  -- {import = "plugins.configs.grep"},
  -- {import = "plugins.configs.harpoon"},
  -- {import = "plugins.configs.lazydev"},
  -- {import = "plugins.configs.lsp-signature"},
  {import = "plugins.configs.nvim-cmp"},
  -- {import = "plugins.configs.nvim-dap"},
  -- {import = "plugins.configs.quickfix"},
  -- {import = "plugins.configs.rainbow"},
  -- {import = "plugins.configs.repl"},
  -- {import = "plugins.configs.screenkey"},
  -- {import = "plugins.configs.textobject"},
  {import = "configs.custom.configs.nvim-tree"},
  {import = "plugins.configs.cd-project"},
  {import = "plugins.configs.chat"},
  {import = "plugins.configs.codeDiff"},
  {import = "plugins.configs.codecompanion"},
  {import = "plugins.configs.comment"},
  {import = "plugins.configs.fugitive"},
  {import = "plugins.configs.gitblame"},
  {import = "plugins.configs.goto-preview"},
  {import = "plugins.configs.hover"},
  {import = "plugins.configs.lazygit"},
  {import = "plugins.configs.live-server"},
  {import = "plugins.configs.luasnip"},
  {import = "plugins.configs.marks"},
  {import = "plugins.configs.mason_tool_installer"},
  {import = "plugins.configs.md-preview"},
  {import = "plugins.configs.mini-surround"},
  {import = "plugins.configs.noice"},
  {import = "plugins.configs.obsidian"},
  {import = "plugins.configs.render-markdown"},
  {import = "plugins.configs.tmux-navigator"},
  {import = "plugins.configs.todo"},
  {import = "plugins.configs.ufo"},
  {import = "plugins.configs.undotree"},
  {import = "plugins.configs.vim-illuminate"},
  {import = "plugins.configs.zen-mode"},
  },
}
return plugins
