return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, { desc = "Toggle Dap UI" })
    vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", { desc = "Toggle Dap UI" })
    vim.keymap.set('n', '<leader>dr', ":DapContinue<CR>", { desc = "Start or Continue Debugger" })
  end
}
