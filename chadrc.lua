-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}
M.base46 = {
	theme = "github_dark",
   transparency = false,
  hl_override = {
    St_file = { bold = true, fg = "sun"},     -- for the file name
    St_gitIcons = { fg = "orange", bold = true }, -- for the git branch
    GitSignsAdd = { fg = "orange" },
    GitSignsChange = { fg = "yellow" },
    GitSignsDelete = { fg = "red" },
  },
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

local quotes = {
  "The only way to do great work is to love what you do. -Steve Jobs",
  "Life is what happens when you're busy making other plans. -John Lennon",
  "The purpose of our lives is to be happy. -Dalai Lama",
  "Get busy living or get busy dying. -Stephen King",
  "You have within you right now, everything you need to deal with whatever the world can throw at you. -Brian Tracy",
  "It does not matter how slowly you go as long as you do not stop. -Confucius",
  "If you're going through hell, keep going. -Winston Churchill",
  "Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence. -Helen Keller",
  "What you do today can improve all your tomorrows. -Ralph Marston",
  "I know not age, nor weariness nor defeat. -Rose Kennedy",
  "If you can dream it, you can do it. -Walt Disney",
  "If your are not having doubts your are not pushing the boundaries far enough. -Tony Fadell",
  "Be strong enough to stand alone, Smart enough to know when you need help and brave enough to ask for it.",
  "Procrastination is the thief of time.",
  "He who sacrifices freedom for security deserves neither. -Benjamin Franklin",
  "The most valuable education is the ability to make yourself do the thing you have to do whe it has to be done, whether you like it or not. -Aldous Huxley",
  "A wise man can learn more from a foolish question than a fool can learn from a wise answer. -Bruce Lee",
  "Hitler never abandoned the cloak of legality, he recognizedthe enourmous psychological value of having the law on his side. Instead, he turned the law inside out and made illegality legal. -Robert Byrd",
  "The future belongs to those who believe in their dreams. -Elanor Roosevelt",
  "The question isn't who is is going to let me; it's who is going to stop me. -Ayn Rand",
  "If they don't have what your want then don't listen to what they say. There is no greater waste of time then justifying your actions to people who have a life you don't want. -Chris Williamson",
  "You are your own worst enemy. You waste time dreaming of the future instead of engaging in the present.Since nothing seems urgent to you your only half involved with what you do. -Chris Williamson",
}

math.randomseed(os.time())
local random_quote = quotes[math.random(#quotes)]
-- local random_quote = quotes[18]

local part1 = random_quote
local part2 = ""
if #random_quote > 150 then
  local space_index = random_quote:find(" ", 150)
  part1 = random_quote:sub(1, space_index)
  part2 = random_quote:sub(space_index + 1)
end

M.nvdash = {
  load_on_startup = true,
  header = {
   "                                          ",
   "        ▄▄▄▄▄███████████████████▄▄▄▄▄     ",
   "      ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   ",
   "     █▀████████▄             ▀▀████ ▀██▄  ",
   "    █▄▄██████████████████▄▄▄         ▄██▀ ",
   "     ▀█████████████████████████▄    ▄██▀  ",
   "       ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    ",
   "         ▀███▄              ▀██████▀      ",
   "           ▀██████▄        ▄████▀         ",
   "              ▀█████▄▄▄▄▄▄▄███▀           ",
   "                ▀████▀▀▀████▀             ",
   "                  ▀███▄███▀                ",
   "                     ▀█▀                   ",
   "                                          ",
  "",
  part1,
  part2,
  "",
  }
}

M.cheatsheet = {
  theme = "grid"
}

M.ui = {
  statusline = {
    theme = "default",
    order = { "mode", "file", "git", "%=", "diagnostics", "lsp", "cwd", "cursor", "page_percent"},
    modules = {
        page_percent = function()
        local current_line = vim.fn.line('.')
        local total_lines = vim.fn.line('$')
        
        if current_line == 1 then
          return "△ Top"
        elseif current_line == total_lines then
          return "▽ Bottom"
        else
          local percentage = math.floor((current_line / total_lines) * 100)
          return string.format("◆ %d%%%%", percentage)
        end
      end,
    }
  }
}

M.general = {
  n = {
    -- ...
    ["<leader>tp"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle transparency",
    },
  },
}

return M
