-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Some servers (e.g. pylsp) send containerName as JSON null, which the LSP
-- client decodes as vim.NIL (userdata). Telescope's lsp_document_symbols
-- calls vim.lsp.util.symbols_to_items directly (bypassing client handlers),
-- and it string-concats containerName, crashing on that userdata value.
do
  local orig_symbols_to_items = vim.lsp.util.symbols_to_items
  local function strip_nil_container_name(symbols)
    for _, symbol in ipairs(symbols) do
      if symbol.containerName == vim.NIL then
        symbol.containerName = nil
      end
      if symbol.children then
        strip_nil_container_name(symbol.children)
      end
    end
  end
  vim.lsp.util.symbols_to_items = function(symbols, bufnr, ...)
    strip_nil_container_name(symbols)
    return orig_symbols_to_items(symbols, bufnr, ...)
  end
end

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
    -- bufmap('n', 'K', vim.lsp.buf.hover, 'Show documentation')
  end
})

-- Specific JDTLS configuration using vim.lsp.start
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.lsp.start({
      name = "jdtls",
      cmd = { '/home/tstall/.local/share/nvim/mason/bin/jdtls' },
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
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
    extendedClientCapabilities = {
      inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
    },
  },
    })
  end,
})

local indentation_filetypes = {
  "python",
  "yaml",
  "pug",
  "haml",
  "nim",
  "coffee",
  "rst",
}

local syntax_filetypes = {
  "c",
  "cpp",
  "objc",
  "objcpp",
  "java",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "lua",
  "rust",
  "go",
  "php",
  "ruby",
  "perl",
  "sh",
  "bash",
  "zsh",
  "fish",
  "html",
  "xml",
  "css",
  "scss",
  "less",
  "sql",
  "cs",
  "kotlin",
  "swift",
  "scala",
  "groovy",
  "zig",
  "dart",
}

local fold_filetypes = vim.list_extend(vim.deepcopy(indentation_filetypes), syntax_filetypes)

vim.api.nvim_create_autocmd("FileType", {
  pattern = fold_filetypes,
  callback = function(args)
    if vim.tbl_contains(indentation_filetypes, args.match) then
      vim.opt_local.foldmethod = "indent"
    elseif vim.tbl_contains(syntax_filetypes, args.match) then
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end

    vim.opt_local.foldenable = true
  end,
})
--   -- Create commands to toggle diagnostics
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
