local options = {
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
    update_cwd = true,
    ignore_list = {}
  },
  view = {
    preserve_window_proportions = true
  },
  actions = {
    change_dir = {
      enable = true,
      global = true,    -- Changes the global CWD when changing directories
      restrict_above_cwd = false
    }
  }
}

nvim_tree.setup(options)
