-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pylsp"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
 end
})
-- Specific JDTLS configuration
require('lspconfig').jdtls.setup({
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  on_init = require("nvchad.configs.lspconfig").on_init,
  capabilities = require("nvchad.configs.lspconfig").capabilities,
  settings = {
    java = {
      configuration = {
        -- Filter out all non-syntax diagnostics
        updateBuildConfiguration = "interactive",
      },
      -- Only show syntax errors
      signatureHelp = { enabled = true },
      completion = { enabled = true },
      format = { enabled = true },
      codeAction = { enabled = true },
      errors = {
        incompleteClasspath = { severity = "ignore" },
      },
      -- Configure diagnostics to only show syntax errors
      settings = {
        java = {
          compile = {
            nullAnalysis = {
              mode = "disabled",
            },
          },
        },
      },
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
    -- Set diagnostic levels - only show syntax errors
    extendedClientCapabilities = {
      progressReportProvider = false,
      classFileContentsSupport = false,
      overrideMethodsPromptSupport = false,
      hashCodeEqualsPromptSupport = false,
      advancedOrganizeImportsSupport = false,
      generateToStringPromptSupport = false,
      advancedGenerateAccessorsSupport = false,
      generateConstructorsPromptSupport = false,
      generateDelegateMethodsPromptSupport = false,
      advancedExtractRefactoringSupport = false,
      inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
    },
  },
})

-- Create commands to toggle diagnostics
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
