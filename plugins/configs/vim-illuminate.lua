---@type NvPluginSpec
return {
  "RRethy/vim-illuminate",
  event = "LspAttach",
  config = function()
    local reference_style = vim.g.reference_style or 'highlight'
    local references_enabled = vim.g.references_enabled ~= false

    local function set_reference_highlights()
      local visual = vim.api.nvim_get_hl(0, { name = 'Visual', link = false })
      local highlight

      if not references_enabled then
        highlight = {
          fg = nil,
          bg = nil,
          bold = false,
          italic = false,
          reverse = false,
          standout = false,
          underline = false,
          undercurl = false,
          underdouble = false,
          underdotted = false,
          underdashed = false,
        }
      elseif reference_style == 'underline' then
        highlight = {
          fg = visual.fg,
          bg = nil,
          bold = false,
          italic = false,
          reverse = false,
          standout = false,
          underline = true,
          undercurl = false,
          underdouble = false,
          underdotted = false,
          underdashed = false,
        }
      else
        highlight = {
          fg = visual.fg,
          bg = visual.bg,
          bold = visual.bold,
          italic = visual.italic,
          reverse = visual.reverse,
          standout = visual.standout,
          underline = false,
          undercurl = false,
          underdouble = false,
          underdotted = false,
          underdashed = false,
        }
      end

      local reference_groups = {
        'IlluminatedWordText',
        'IlluminatedWordRead',
        'IlluminatedWordWrite',
        'LspReferenceText',
        'LspReferenceRead',
        'LspReferenceWrite',
      }

      for _, group in ipairs(reference_groups) do
        vim.api.nvim_set_hl(0, group, highlight)
      end
    end

    local function set_reference_style(style)
      reference_style = style
      vim.g.reference_style = style
      references_enabled = true
      vim.g.references_enabled = true
      set_reference_highlights()
    end

    local function toggle_reference_highlights()
      references_enabled = not references_enabled
      vim.g.references_enabled = references_enabled
      set_reference_highlights()
    end

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

    set_reference_highlights()

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = set_reference_highlights,
    })

    vim.api.nvim_create_user_command('ReferenceHighlight', function()
      set_reference_style('highlight')
    end, { desc = 'Use background highlight for symbol references' })

    vim.api.nvim_create_user_command('ReferenceUnderline', function()
      set_reference_style('underline')
    end, { desc = 'Use underline for symbol references' })

    vim.api.nvim_create_user_command('ReferenceToggle', function()
      toggle_reference_highlights()
    end, { desc = 'Toggle symbol reference styling on or off' })
  end,
};
