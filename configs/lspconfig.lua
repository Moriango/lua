-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- LSP server configurations using vim.lsp.start (no deprecation warnings)
local servers = {
  {
    name = "html",
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
  },
  {
    name = "cssls", 
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
  },
  {
    name = "pylsp",
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml", "setup.py" }, { upward = true })[1]),
  },
  {
    name = "denols",
    cmd = { "deno", "lsp" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = vim.fs.dirname(vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1]),
  },
}

-- Start LSP servers using vim.lsp.start
for _, server in ipairs(servers) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = server.filetypes,
    callback = function()
      vim.lsp.start(vim.tbl_extend("force", server, {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }))
    end,
  })
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
-- Specific JDTLS configuration using vim.lsp.start
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.lsp.start({
      name = "jdtls",
      cmd = { '/opt/homebrew/bin/jdtls' },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, { upward = true })[1]),
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
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
  end,
})

--   -- Create commands to toggle diagnostics
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
