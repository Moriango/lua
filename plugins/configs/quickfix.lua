---@type NvPluginSpec
return{
  {'kevinhwang91/nvim-bqf', ft = 'qf'},

  {'junegunn/fzf', run = function()
      vim.fn['fzf#install']()
    end
  },
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
}
