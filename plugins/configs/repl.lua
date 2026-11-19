---@type NvPluginSpec
return {
  "Vigemus/iron.nvim",
  lazy = false,
  cmd = {
    "IronRepl",
    "IronRestart",
    "IronFocus",
    "IronHide",
    "IronAttach",
    "IronSend",
    "IronReplHere",
    "IronWatch",
  },
  config = function()
    local iron = require("iron.core")
    local has_executable = function(name)
      return vim.fn.executable(name) == 1
    end

    local repl_definition = {
      cpp = {
        command = { "/snap/bin/cling", "-std=c++20" },
      },
    }

    iron.setup({
      config = {
        -- Whether a REPL should be discarded or not
        scratch_repl = false,
        -- Use Python by default and only enable Cling if it is installed.
        repl_definition = repl_definition,
        -- Define how the REPL window opens (e.g., vertical split)
        repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
      },
    })
  end,
}

