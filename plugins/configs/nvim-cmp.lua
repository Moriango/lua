return {
    "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.preselect = cmp.PreselectMode.None
        opts.completion = opts.completion or {}
        opts.completion.completeopt = "menu,menuone,noselect"
        opts.mapping["<CR>"] = cmp.mapping.confirm { select = false }
        opts.mapping["<C-p>"] = cmp.mapping(function(fallback)
          local ok, suggestion = pcall(require, "copilot.suggestion")
          if ok and suggestion.is_visible() then
            suggestion.accept()
          else
            fallback()
          end
        end, { "i" })
      end,
}
