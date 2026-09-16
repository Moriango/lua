return {
    "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.preselect = cmp.PreselectMode.None
        opts.completion = opts.completion or {}
        opts.completion.completeopt = "menu,menuone,noselect"
        opts.mapping["<CR>"] = cmp.mapping.confirm { select = false }
      end,
}
