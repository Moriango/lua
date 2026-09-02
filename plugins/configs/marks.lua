---@type NvPluginSpec
return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    -- Disable the plugin's default mappings so gm and gM can navigate marks.
    default_mappings = false,
    cyclic = true,
    mappings = {
      -- Press <leader>m followed by a letter to set that mark.
      set_next = "M",
    },
  },
}

-- Native Vim mark commands remain available:
--   mx       Set mark x
--   m,       Set the next available lowercase mark
--   m;       Toggle the next available mark on the current line
--   dmx      Delete mark x
--   dm-      Delete marks on the current line
--   dm<Space> Delete marks in the current buffer
