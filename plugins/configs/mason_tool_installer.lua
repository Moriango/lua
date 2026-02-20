---@type NvPluginSpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- C++ debug and test tools
        "clangd",
        "clang-format",
        "codelldb",
        -- Java debug and test tools
        "java-debug-adapter",
        "java-test",
        
        -- Common linters and formatters
        "lua-language-server",
        "stylua",
        "prettier",
        "eslint-lsp",
        
        -- Optional additional tools you might want
        "json-lsp",
        "yaml-language-server",
        "typescript-language-server",
      },
      
      -- Auto-install tools
      auto_update = true,
      run_on_start = true,
      
      -- Start tools automatically
      -- start_delay = 3000, -- 3 second delay
    })
  end
}

