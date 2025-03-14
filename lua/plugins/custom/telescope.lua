---@type NvPluginSpec
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                path_display = "tail",
                layout_config = {
                    horizontal = {
                        height = 0.9,
                        preview_cutoff = 120,
                        prompt_position = "bottom",
                        width = 0.8
                    }
                },
                prompt_prefix = "🔍 ",
                selection_caret = "➤ ",
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<Esc>"] = actions.close,
                    },
                    n = {
                        ["q"] = actions.close
                    }
                }
            }
        })
  end,
}
