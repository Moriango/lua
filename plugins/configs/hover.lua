---@type NvPluginSpec
return {
  "lewis6991/hover.nvim",
  event = { "LspAttach", "BufReadPost" },
  enabled = true,
  config = function()
    require("hover").setup({
      init = function()
        require("hover.providers.lsp")
        require("hover.providers.diagnostic")
      end,
      providers = {
        "hover.providers.lsp",
        "hover.providers.diagnostic",
        "hover.providers.dictionary",
        "hover.providers.man",
        "hover.providers.dap",
        "hover.providers.highlight",
        -- "hover.providers.gh",
        -- "hover.providers.gh_user",
        -- "hover.providers.fold_preview",
      },
      preview_opts = {
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
      },
      preview_window = false,
      title = true,
      mouse_providers = {
        "hover.providers.lsp",
      },
      mouse_delay = 1000,
    })

    -- Keymaps
    local hover = require("hover")

    -- Helper function to check if hover window is open
    local function is_hover_window_open()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match("hover://") or vim.api.nvim_buf_get_option(buf, 'filetype') == 'hover' then
          return true, win
        end
      end
      return false, nil
    end

    -- Improved function to switch between hover sources
    local function ensure_open_and_switch(dir)
      local is_open, _ = is_hover_window_open()
      
      if not is_open then
        -- Open hover and wait longer for it to initialize
        hover.open()
        vim.defer_fn(function()
          hover.switch(dir)
        end, 150)  -- Increased delay to 150ms
      else
        -- Window is already open, switch immediately
        hover.switch(dir)
      end
    end

    -- Open hover window
    vim.keymap.set("n", "K", function()
      hover.open()
    end, { desc = "hover.nvim (open)" })
    
    -- Enter hover window (allows using j/k to navigate)
    vim.keymap.set("n", "KK", function()
      hover.enter()
    end, { desc = "hover.nvim (enter)" })

    -- Primary keybindings for switching sources
    vim.keymap.set("n", "KN", function()
      ensure_open_and_switch("next")
    end, { desc = "hover.nvim (next source)" })
    vim.keymap.set("n", "KP", function()
      ensure_open_and_switch("previous")
    end, { desc = "hover.nvim (previous source)" })
    
    vim.keymap.set("n", "<MouseMove>", function()
      hover.mouse()
    end, { desc = "hover.nvim (mouse)" })
    vim.o.mousemoveevent = true
  end,
}
