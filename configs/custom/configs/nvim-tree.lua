---@type NvPluginSpec
return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  config = function()
    require('nvim-tree').setup({
      view = {
        side = 'left',
        width = 40,
      },
      sync_root_with_cwd = true,  -- Sync with current working directory
      respect_buf_cwd = true,     -- Change working directory when opening a file
      update_focused_file = {
        enable = true,            -- Update the tree to show the current file
        update_root = false,       -- Update root directory to current file's directory
      },
      filters = {
        dotfiles = false, -- Show hidden files by default
      },
      renderer = {
        indent_markers = {
          enable = true, -- Show indent markers for nested folders
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
          },
        },
        root_folder_label = false,  -- Add this line to remove the path at the top
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Don't close tree when opening a file
        },
      },
    })
  end,
}
