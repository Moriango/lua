return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCLI",
    "CodeCompanionCmd",
    "CodeCompanionCodeReview",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
  },
  opts = {
    interactions = {
      chat = {
        adapter = "copilot",
      },
      inline = { adapter = "copilot" },
    },
  },
  keys = {
    { "<leader>cp", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "x" }, desc = "Toggle CodeCompanion Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
  },
}