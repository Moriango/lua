---@type NvPluginSpec
return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/vaults/personal/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/vaults/personal/*.md",
    "BufReadPre " .. vim.fn.expand "~" .. "/vaults/work/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/vaults/work/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },

    templates = {
      folder = "templates",
      substitutions = {
        weekday = function()
          return tostring(os.date "%A")
        end,
        carryover = function()
          local client = require("obsidian").get_client()
          local vault_dir = tostring(client.dir)
          local templates_dir = tostring(client.dir / client.opts.templates.folder)

          -- find the most recently modified DailyTasks note
          local newest_file, newest_mtime = nil, -1
          for _, f in ipairs(vim.fn.globpath(vault_dir, "**/*.md", false, true)) do
            if not vim.startswith(f, templates_dir) then
              local header = vim.fn.readfile(f, "", 10)
              for _, line in ipairs(header) do
                if line:match "^id:%s*DailyTasks%s*$" then
                  local stat = vim.uv.fs_stat(f)
                  if stat and stat.mtime.sec > newest_mtime then
                    newest_mtime = stat.mtime.sec
                    newest_file = f
                  end
                  break
                end
              end
            end
          end

          if not newest_file then
            return ""
          end

          -- collect unchecked "- [ ]" items from the first "##" section
          local incomplete = {}
          local in_section = false
          for _, line in ipairs(vim.fn.readfile(newest_file)) do
            if line:match "^##%s" then
              if in_section then
                break
              end
              in_section = true
            elseif in_section and line:match "^%s*-%s*%[%s*%]" then
              table.insert(incomplete, line)
            end
          end

          return table.concat(incomplete, "\n")
        end,
      },
    },

    note_id_func = function()
      return os.date "%m-%d-%y"
    end,

    -- see below for full list of options 👇
  },
}
