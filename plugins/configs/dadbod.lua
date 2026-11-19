return {
  -- vim-dadbod-ui: sidebar "database explorer" (like a mini DBeaver) built on top of vim-dadbod.
  -- Lists connections, schemas, and tables; lets you open query buffers and run them.
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      -- vim-dadbod: the core engine. Runs SQL against a database via :DB and
      -- shells out to the DB's CLI client (psql, mysql, sqlite3, ...), so those must be installed.
      { "tpope/vim-dadbod", lazy = true },
      -- vim-dadbod-completion: provides table/column completion sources from the
      -- active connection. Only needed in SQL buffers, so load by filetype.
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    -- Lazy-load: the plugin only loads when one of these commands or keys is used.
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
    },
    -- `init` runs at startup (before the plugin loads); vim-dadbod-ui reads its g: vars when loaded.
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1 -- use Nerd Font icons in the drawer
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/dadbod_ui" -- where saved queries/connections live
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1 -- show messages with :echo instead of popups
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 40

      -- In SQL buffers, add the dadbod completion source to nvim-cmp
      -- (buffer-local, so other filetypes keep their normal sources).
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          -- <CR> runs the query (normal: whole buffer, visual: selection); same as <leader>S
          vim.keymap.set({ "n", "v" }, "<CR>", "<Plug>(DBUI_ExecuteQuery)", {
            buffer = true,
            remap = true, -- needed because the target is a <Plug> mapping
            desc = "Run query",
          })

          local ok, cmp = pcall(require, "cmp")
          if not ok then
            return
          end
          cmp.setup.buffer {
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          }
        end,
      })
    end,
  },
}
