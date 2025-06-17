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
    bufmap('n', 'I', '<cmd>lua vim.lsp.buf.hover()<cr>')

 end
})
-- Specific JDTLS configuration
require('lspconfig').jdtls.setup({
  cmd = { '/opt/homebrew/bin/jdtls' },  -- Add this line
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  on_init = require("nvchad.configs.lspconfig").on_init,
  capabilities = require("nvchad.configs.lspconfig").capabilities,
  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      signatureHelp = { enabled = true },
      completion = { enabled = true },
      format = { enabled = true },
      codeAction = { enabled = true },
      -- Disable all errors
      errors = {
        incompleteClasspath = { severity = "ignore" },
      },
      -- Disable all diagnostics
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
  -- Add this to completely disable diagnostics
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      local filtered_diagnostics = {}
      for _, diagnostic in ipairs(result.diagnostics) do
        -- Only keep diagnostics with "syntax" in the message
        local message = diagnostic.message:lower()
        -- Keep syntax errors and filter common Java errors
        local should_filter =
            -- message:find("cannot be resolved") or        -- Unresolved symbols
            -- message:find("cannot be resolved to a type") or -- Unknown types
            -- message:find("the import .* cannot be resolved") or -- Import errors
            message:find("null pointer access") or      -- Null pointer warnings
            message:find("resource leak") or            -- Resource management
            message:find("dead code") or                -- Unreachable code
            message:find("unused import") or            -- Unused imports
            message:find("unused variable") or          -- Unused variables
            message:find("missing serial") or           -- Serialization warnings
            message:find("raw type") or                 -- Generic type warnings
            message:find("syntax") or                   -- Syntax Errors
            message:find("illegal character") or                   -- Syntax Errors
            message:find("unexpected type") or                   -- Syntax Errors
            message:find("class") or                   -- Syntax Errors
            message:find("interface") or                   -- Syntax Errors
            message:find("enum") or                   -- Syntax Errors
            message:find("record") or                   -- Syntax Errors
            message:find("unchecked conversion")        -- Type casting warnings

        -- Only keep diagnostics that are syntax errors or not in the filter list
            if should_filter then
                table.insert(filtered_diagnostics, diagnostic)
            end
        end
      result.diagnostics = filtered_diagnostics
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
})

--   -- Create commands to toggle diagnostics
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
