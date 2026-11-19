-- Fallback hover source for Lua that renders Neovim's own :help pages for the
-- expression under the cursor (e.g. table.insert, string.format, vim.tbl_deep_extend).
-- lua_ls hover already covers most of this, but stdlib entries documented only
-- in Neovim's bundled runtime docs (lua.txt, builtin.txt, etc.) sometimes have
-- no attached signature help. This reuses the real :help system directly, so
-- it needs no external tools.

--- @return string
local function dotted_expr_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local start_idx, end_idx = col, col
  while start_idx > 1 and line:sub(start_idx - 1, start_idx - 1):match("[%w_%.]") do
    start_idx = start_idx - 1
  end
  while end_idx < #line and line:sub(end_idx + 1, end_idx + 1):match("[%w_%.]") do
    end_idx = end_idx + 1
  end

  local expr = line:sub(start_idx, end_idx)
  return (expr:gsub("^%.+", ""):gsub("%.+$", ""))
end

--- @param tag string
--- @return string[]?
local function help_lines_for_tag(tag)
  local ok = pcall(vim.cmd, "silent! help " .. vim.fn.escape(tag, " \\"))
  if not ok or vim.bo.filetype ~= "help" then
    return nil
  end

  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local buf = vim.api.nvim_get_current_buf()
  local last_line = math.min(vim.api.nvim_buf_line_count(buf), cursor_line + 25)
  local lines = vim.api.nvim_buf_get_lines(buf, cursor_line - 1, last_line, false)

  vim.cmd("helpclose")

  while #lines > 0 and lines[#lines]:match("^%s*$") do
    table.remove(lines)
  end

  return #lines > 0 and lines or nil
end

--- @param _params Hover.Provider.Params
--- @param done fun(result?: Hover.Provider.Result)
local function execute(_params, done)
  local expr = dotted_expr_under_cursor()
  if expr == "" then
    done()
    return
  end

  local last_part = expr:match("[^.]+$") or expr
  local candidates = { expr .. "()", expr, last_part .. "()", last_part }

  for _, tag in ipairs(candidates) do
    local ok, lines = pcall(help_lines_for_tag, tag)
    if ok and lines then
      done({ lines = lines, filetype = "help" })
      return
    end
  end

  done()
end

--- @type Hover.Provider
return {
  name = "LuaHelp",
  priority = 90,
  enabled = function(bufnr)
    return vim.bo[bufnr].filetype == "lua"
  end,
  execute = execute,
}
