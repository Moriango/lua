-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.pylsp.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    pylsp = {
      enabled = true,
      plugins = {
        pylint = { enabled = true },
        pyflakes = { enabled = true },
        pycodestyle = {
          enabled = true,
          ignore = {
            "E501"
          },
        },
        mccabe = { enabled = true },
        pydocstyle = { enabled = true },
        yapf = { enabled = true },
        autopep8 = { enabled = true },
        rope_completion = { enabled = true },
        flake8 = {
          enabled = true,
          ignore = {
            "E501"
          },
        },
        mypy = {enabled = true},
      },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  diagnostics = false,
  cmd = { "clangd", "--background-index"},
  filetypes = { "c", "cpp", "objc", "objcpp"},
  settings = {
    clangd = {
      fallbackFlags = { "-std=c++17" },
    }
  }
}
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
