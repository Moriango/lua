---@type NvPluginSpec
return {
  "numToStr/Comment.nvim",
  dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  init = function()
    local map = vim.keymap.set
    local api = require "Comment.api"

    map("v", "<leader>/", function()
      api.toggle.blockwise.current()
    end, { desc = "Comment toggle (block) in single line" })

    map("n", "<leader>/", function()
      api.toggle.linewise.current()
    end, { desc = "Comment toggle" })

    map(
      "x",
      "<leader>/",
      "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@",
      { desc = "Comment toggle (aware of context)" }
    )
  end,
  ---@param opts CommentConfig
  config = function(_, opts)
    local comment = require "Comment"
    local ts_addon = require "ts_context_commentstring.integrations.comment_nvim"
    local ts_pre_hook = ts_addon.create_pre_hook()
    local comment_ft = require "Comment.ft"
    local comment_utils = require "Comment.utils"

    opts.pre_hook = function(ctx)
      local commentstring = ts_pre_hook(ctx)
      if commentstring then
        return commentstring
      end

      return comment_ft.get(vim.bo.filetype, ctx.ctype)
        or comment_ft.get(vim.bo.filetype, comment_utils.ctype.linewise)
    end

    comment.setup(opts)
  end,
}
