---@type NvPluginSpec
return {
  "https://forge.barrettruth.com/barrettruth/diffs.nvim",
  -- Needs to be loaded eagerly: it hooks FileType/OptionSet/VimEnter autocmds
  -- that must be registered before fugitive/gitsigns/diff-mode ever fire.
  lazy = false,
  init = function()
    vim.g.diffs = {
      integrations = {
        fugitive = true,
        gitsigns = true,
        telescope = true,
      },
    }

    vim.api.nvim_create_user_command("DiffRepo", "Diff review", { desc = "Full-repo review diff" })
  end,
}
