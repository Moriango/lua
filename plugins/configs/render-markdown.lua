---@type NvPluginSpec
return {
      'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    event = "BufReadPost *.md",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        enabled = true,
        file_types = { 'markdown' },
        render_modes = { 'n', 'c', 't' },
    },
    config = function(_, opts)
        require('render-markdown').setup(opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                require('render-markdown').enable()
            end,
        })
    end,
}
