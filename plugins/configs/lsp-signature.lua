---@type NvPluginSpec
return {
  enabled = true,
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  config = function()
    require("lsp_signature").setup({
      bind = true, -- This is mandatory
      handler_opts = {
        border = "rounded"
      },
      hint_enable = true, -- Show hint in virtual text
      hint_prefix = "🐼 ", -- Icon before parameter hint
      floating_window = true, -- Show signature in floating window
      transparency = 10, -- Slight transparency
    })
  end,
}
