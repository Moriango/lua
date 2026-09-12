-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@class M: ChadrcConfig
local M = {}

M.colorify = {
  enabled = false,
}

M.base46 = {
	theme = "chocolate",
    transparency = false,
  -- Status and git highlight overrides: file names, branch icons, and diff signs.
  -- Example: St_file for main.cpp, GitSignsAdd for +new lines, GitSignsDelete for -old lines.
  hl_override = {
    St_file = { bold = true, fg = "#facc15" },
    St_gitIcons = { fg = "#fb923c", bold = true },
    GitSignsAdd = { fg = "#fbbf24" },
    GitSignsChange = { fg = "#facc15" },
    GitSignsDelete = { fg = "#f87171" },
    -- Identifier: general variable names; example: count, name, result
        -- @variable: Tree-sitter variable names; example: total, user_name, idx
        -- @variable.builtin: built-in or special variables; example: self, this, super, nil
        -- @property: object fields / member access; example: obj.value, user.name, p.age
        -- @type: class/type names; example: Person, Vector, MyStruct
        -- @type.builtin: built-in language types; example: int, string, list, float
        -- @constant: constants; example: PI, MAX_VALUE, DEBUG
        -- @namespace: namespace/module names; example: std, mylib, foo.bar
    Identifier = { fg = "#ffd166" },
    ["@variable"] = { fg = "#ffd166" },
    ["@variable.builtin"] = { fg = "#ff9f43" },
    ["@property"] = { fg = "#d6b7ff", italic = true },
    ["@type"] = { fg = "#86efac", bold = true },
    ["@type.builtin"] = { fg = "#4ade80" },
    ["@constant"] = { fg = "#f9a8d4", bold = true },
    ["@namespace"] = { fg = "#c4b5fd" },
  },
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

local quotes = {
    "Can a weak person be good? Does it take strength to prove kindness?",
    "If you're tired of starting over, stop giving up.",
    "The mind is a powerful force. It can enslave us or empower us. It can plunge us into the depths of miserry or take us to the height of ectsasy. Learn to use the power wisely.",
    "85% of what we worry about never happens -Robert Leahy Ph.D, The worry cure",
    "As long as you're indebted to their sacrifice there are things you cannot back down from ",
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
    "Accept responsibility for you life. Know that it is you who will get you where you want to go, no one else.",
    "No matter how bad it is or how hard it gets, I am going to make it.",
    "Do not wait; the time will never be 'Just right'. Start where you stand and work with whatever tools you may have at your command and better tools will be found as you go along - George Herbert",
    "Good, better, best. Never let it rest till your good is better and you better is best -St. Jerome",
    "Is the mind the same as the brain or do we have souls?",
    "Fear is not real the only place that fear can exist is in our thoughts of the future. It isa product of our imagination causing us to fear things that may never exist. Fear is a choice.",
    "To many of us are not living our dreams because we are living our fears. Life has not limitations except the ones you make.",
    "Everyday do something that scares you. Get comfortable being uncomfortable. ",
    "Man cannot discover new oceans unless he has the courage to lose sight of the shore.",
    "Successful people do the work whether they want to or not.",
    "Eyesight; what you see. Mindsight; How you interpret what you see. Loser are people who have not discovered how to win.",
    "When I dare to be powerful, to use my strength in the service of my vision, then it becomes less and less important whether I'm afraid.",
    "When you're no longer willing to tolerate womething that's when your life changes.",
    "Put your heart mind and soul into even you smallest acts. This is the secret of success -Swami Sivananda",
    "You just can't beat the person that never gives up. -Babe Ruth",
    "If you don't have the ability you end up playing in a rock band - Buddy Rich",
    "There will be obstacles. There will be doubters. There will be mistakes. But with hardwork there are no limits. -Michael Phelps",
    "When you gaze long enough into the abyss the abyss gazes back at you but the abyss is nothingness. A void can only have what you bring into it so, I ask you what do you bring?",
    "We have to let go of the life we have planned to accept the one we have waiting for us. -Joseph Cambel",
    "If you wait until your comfortable before making a behavioral change you will never change. You ahve to go through that feeling over and over until you are comfortable.",
    "The only way to deal with an unfree world is to become so absolutely free that your very existence is an act of rebellion. -Alber Camus",
    "Character cannot be devloped in ease and quiet. Only through experience of trial and suffering can the soul be strengthened, ambition inspired and success achieved. -Helen Keller",
    "Can you imaging yourself in 10 years if instead of avoiding the things you should do, you actually did them every single day. -Jordan Peterson",
    "If you deliberatly plan to be less than you are capable of being then I warn you that you'll be deeply unhappy for the rest of your life. You will be evading you own capcities and abilities.",
    "You are all alone in this world. Once you've got that down nothing hurts anymore.",
    "Boredom, possitivity  and stagnation; These are the beginning of mental illness which propagate itself like the scum on a stagnant pond.",
    "Life is like a bicycle, to keep you balance you mus keep moving forward -Albert Einstein",
    "Life is a storm. You will bask in the sungligh one moment and be shattered on the rocks the next. What makes you a man is what you do when that storm comes. You must look into that storm and shout \"Do you worst, for I will do mine\" Then the fates will know you as we know you, a man.",
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

local headers = {
  {
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
  },
  vim.split(
    [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣶⡆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣶⣦⠀⠀⠀⣀⣠⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣴⣶⣿⠿⠿⠟⠳⡄⣿⣷⣾⣏⠁⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣀⣤⠴⠚⠉⠁⠸⠟⠋⠀⢠⣿⣦⣴⡇⣿⣿⣿⣿⡄⠀⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣠⣤⡶⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣷⣿⣿⣿⣿⣷⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⠿⣟⣿⣿⡿⠟⠋⠁⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⣿⢁⣸⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⠀⢻⣿⣿⣆⠀⠸⠿⣿⣿⡿⠛⣉⣴⠿⢟⡫⠥⠐⠒⠋⠉⠉⠉⠁⠀⠀⣀⣁⣀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⠀⠘⣿⣿⣿⣤⡴⠞⠉⠹⣷⠚⠉⠠⡐⠁⢀⣤⣶⣶⣶⣶⣾⣿⣿⣿⢿⡟⠛⠛⠿⣦⣄⠀⠀⠀⠀
⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢻⣿⣿⠋⠀⠀⠀⠀⢹⡆⠀⠈⠀⠀⡺⠋⠀⢸⠁⠈⠙⣿⣿⠉⠀⣿⠀⠀⠀⠈⢹⢿⢀⠀⠀
⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⢠⣿⣿⣿⠿⢿⣿⣿⣿⣿⡇⠀⡘⣿⠇⠀⠀⠀⠀⠀⠀⢷⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⠀⠉⠁⠀⣰⠏⠀⠀⠀⠠⠋⠸⢸⠀⠀
⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⠟⠀⢀⣾⣿⣿⣿⣷⣦⡐⠬⣙⡻⢿⣤⡇⠟⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠤⣀⠀⠈⠒⠦⠴⠚⠁⣀⠀⠀⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢻⣿⣿⣿⣿⣿⢃⡄⠀⣸⣿⣿⣿⣿⣿⣿⣿⣷⣬⣿⡓⣸⡇⢠⣄⣀⠀⠀⠀⣀⣤⣾⣿⣦⣄⠀⠐⠖⠂⠀⠈⠉⠐⠒⠒⠈⠁⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⠃⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢛⣩⣶⣿⣿⣯⡉⠉⣩⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⡀⠀⠀⢿⣿⡟⢻⠏⢠⣿⣿⣿⣿⣿⠿⠟⣛⣩⣤⣶⣿⣿⣿⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠛⣓⣲⡀⠀⠀⠀⠀⠀⠀⣀⣤⡆
⠀⠀⣿⣦⣤⣬⣟⢷⣴⣠⣿⠿⠟⣛⡉⠐⢶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣛⡛⠛⠟⠁⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀
⠀⠀⠹⣿⣿⣿⣿⣦⣍⠍⢀⣼⣿⣿⣿⠇⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠶⣂⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀
⠀⠀⠀⠘⢿⣯⣤⡄⠀⢰⣿⣿⣿⡟⣡⣾⣿⣷⣶⣤⣌⡙⠻⢿⣿⣿⣿⣿⣿⣇⢸⣿⣿⣿⣿⣿⣿⣿⠟⢋⣭⣶⣶⣤⠾⣿⣷⣄⠹⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀
⠀⠀⠀⠀⠈⢿⣿⣧⠀⢸⣿⣿⢋⣴⣿⠛⡇⠈⡟⠉⢻⡿⠷⣦⣌⣉⣍⣭⣭⣭⣭⣭⣩⣭⣍⣉⣉⣥⡾⠻⣿⠏⠙⡇⠀⠘⢸⣿⣦⠈⠻⣿⣿⣿⣿⠏⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⢻⣿⡀⢸⣿⠃⣾⣿⠉⢑⣧⣀⡇⠀⠈⡇⠀⢸⠃⠀⢹⡟⠉⠙⣿⡟⠉⠻⣿⠋⠉⢿⠀⠀⢸⠀⠀⣯⣠⣴⣿⣿⣿⡇⢀⠘⣿⣿⠟⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠻⣷⡈⢯⣸⣿⡏⠀⠀⠀⠉⠛⠶⠶⣧⣀⣸⠀⠀⠀⡇⠀⠀⢸⠀⠀⠀⡇⠀⠀⢘⣀⣀⠼⠖⠋⠁⠀⣿⣿⣿⠿⠃⣴⣤⣿⠏⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣦⡉⣉⢀⣀⣿⣇⣀⣇⠀⠀⡄⠀⠉⡍⠉⠛⠓⠒⠒⠚⡒⠒⠒⠛⠛⠋⢩⠁⠀⣶⠀⠀⣷⣾⡿⠛⢁⣤⣾⣿⡿⠟⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣶⣽⣛⡻⢿⣿⣶⣾⣿⡀⢀⡇⠀⠀⣸⠀⠀⢠⡇⠀⠀⡇⠀⠀⣼⠀⢀⣿⣶⣾⠟⠉⣠⣴⣿⣿⠟⠋⠀⢀⣠⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣠⣀⠀⠉⢻⣿⣿⣯⣍⠳⣬⣛⢿⣿⣿⣿⣷⣤⣴⣿⣆⣠⣾⣧⣀⣼⣿⣄⣴⣿⣿⣿⡿⠛⣁⣴⣾⣿⣿⣿⣿⣤⡤⠒⠉⠉⢿⡷⢦⡀⠀⠀
⠀⠀⠀⠀⢀⣤⠾⣿⠋⠉⢛⠲⢿⣿⣿⣿⣿⣷⣤⡙⢷⣌⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢋⣠⣾⣿⣿⣿⣿⣿⡿⢟⣥⣾⣦⡀⢄⡠⠀⠉⠿⣷⡄
⠀⠀⢀⣾⡿⠛⠁⠈⠳⢶⣿⣿⣦⣙⠻⣿⣿⣿⣿⣷⣄⠙⢷⣦⡙⢿⣿⡿⠿⠿⠿⠿⠿⣝⠛⠛⠛⣁⠔⢁⣾⣿⣿⣿⣿⡿⢋⣴⣿⣿⡿⢋⣴⣿⣄⠀⢀⣤⣿⠁
⠀⠀⠘⣿⣷⣤⡀⣠⣶⣦⡙⢿⣿⣿⣷⣌⠻⣿⣿⣿⣿⣧⡀⠙⠛⣀⡀⢠⣶⣶⣶⣶⣶⣀⣸⣿⣯⣴⣦⣤⣿⣿⣿⡿⢋⣴⣿⣿⡿⢋⣴⣿⣿⡿⣫⠶⠛⣿⠃⠀
⠀⠀⠀⠈⢻⡛⠿⣿⣿⣿⣿⣶⡍⠻⣿⣿⣷⠝⢿⣿⣿⡿⠛⠢⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠻⣿⣿⠟⠠⠛⢿⣿⠟⣱⣿⣿⡿⢫⣾⠃⠀⢠⠃⠀⠀
⠀⠀⠀⠀⠀⢳⡀⠈⣿⣿⣿⣿⣿⣦⡈⠛⠁⠀⠀⠙⡏⠀⠀⠀⠀⠀⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⢈⠏⠀⠀⠀⠠⠋⠘⣿⣿⢋⡔⠉⢻⠁⠠⠂⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠱⡄⠏⠀⠉⢿⡿⠋⠙⢄⠀⠀⠀⢀⡈⢆⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⢠⠊⣴⡄⠀⠀⠄⠀⠀⠀⣱⡏⡀⠀⢀⠜⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠢⡀⠤⠴⠛⢄⠀⠈⠣⡀⠀⣾⣿⣬⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢦⣾⣿⡗⢀⣎⠀⠀⠀⡜⠙⠛⢃⠔⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀⠁⠀⢠⣷⡄⠹⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⡟⢀⣾⣿⣇⠄⡜⠀⡠⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠢⢶⣿⡜⣿⣿⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⢋⣾⠖⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]],
    "\n",
    { trimempty = true }
  ),
  vim.split(
    [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⠤⠶⠶⠶⠶⠶⠶⢀⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣀⡴⠞⠋⠁⠀⠀⠀⠀⠀⠀⠀⢠⣿⡿⠀⠙⠳⢦⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⠃⠀⠀⠀⠀⠉⠳⣄⠀⠀⠀⠀⠀
⠀⠀⠀⢠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣇⣠⣴⡶⠀⠀⠀⠀⠈⠳⣄⠀⠀⠀
⠀⠀⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀
⠀⣰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀
⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⢿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄
⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⢠⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡇
⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⠃⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿
⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣷⣾⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿
⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇
⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠁
⠀⠘⣇⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⠀
⠀⠀⠘⢧⠀⠀⠀⠀⠀⠀⠘⠋⠉⣼⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠃⠀⠀
⠀⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⢰⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠳⣤⡀⠀⠀⢀⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠞⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⠂⣾⣿⠃⠀⠀⠀⠀⠀⠀⢀⣀⣠⡴⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡿⠁⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]],
    "\n",
    { trimempty = true }
  ),
}

local function build_nvdash_header()
  local random_logo = headers[math.random(#headers)]
  local header = {}

  for _, line in ipairs(random_logo) do
    table.insert(header, line)
  end

  table.insert(header, "")
  table.insert(header, part1)
  if part2 ~= "" then
    table.insert(header, part2)
  end
  table.insert(header, "")

  return header
end

M.nvdash = {
  load_on_startup = true,
  header = build_nvdash_header(),
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
