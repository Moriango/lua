-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Helper function to find root directory with caching
local root_cache = {}
local function find_root(patterns, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  
  -- Check cache first
  if root_cache[bufname] then
    return root_cache[bufname]
  end
  
  -- Find root directory
  local root = vim.fs.dirname(vim.fs.find(patterns, { 
    upward = true, 
    path = vim.fs.dirname(bufname),
    limit = 1  -- Stop at first match for speed
  })[1])
  
  -- Fallback to current directory if no root found
  root = root or vim.fs.dirname(bufname)
  
  -- Cache the result
  root_cache[bufname] = root
  return root
end

-- LSP server configurations using vim.lsp.start (no deprecation warnings)
local servers = {
  {
    name = "html",
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_patterns = { ".git", "package.json" },
  },
  {
    name = "cssls", 
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_patterns = { ".git", "package.json" },
  },
  {
    name = "pylsp",
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_patterns = { ".git", "pyproject.toml", "setup.py" },
    settings = {
      pylsp = {
        plugins = {
          -- Enable better code completion and hover
          jedi_completion = { enabled = true, fuzzy = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true, all_scopes = true },
          -- Disable formatters/linters (use conform.nvim instead)
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          pylint = { enabled = false },
          pycodestyle = { enabled = false },
          flake8 = { enabled = false },
        },
      },
    },
  },
  {
    name = "denols",
    cmd = { "deno", "lsp" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_patterns = { "deno.json", "deno.jsonc" },
  },
  {
    name = "clangd",
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_patterns = { ".git", "compile_commands.json", "compile_flags.txt" },
  },
}

-- Start LSP servers using vim.lsp.start
for _, server in ipairs(servers) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = server.filetypes,
    callback = function(args)
      -- Calculate root_dir only when needed
      local root_dir = find_root(server.root_patterns, args.buf)
      
      vim.lsp.start(vim.tbl_extend("force", server, {
        root_dir = root_dir,
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }))
    end,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = {buffer = args.buf, desc = desc}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Signature help - shows function parameters and usage
    -- Note: <C-K> and <C-k> are the same key in Neovim, so do not use Ctrl+k here.
    bufmap('n', '<leader>K', vim.lsp.buf.signature_help, 'Show signature help')
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
