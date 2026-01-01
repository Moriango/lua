---@type NvPluginSpec
return {
  "RRethy/vim-illuminate",
  event = "LspAttach",
  config = function()
    require('illuminate').configure({
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      -- delay: delay in milliseconds
      delay = 100,
      -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'NvimTree',
        'neo-tree',
      },
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = true,
      -- min_count_to_highlight: minimum number of matches required to perform highlighting
      min_count_to_highlight = 1,
    })
  end,
};
