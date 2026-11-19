-- Fallback hover source for Python builtin/stdlib methods (e.g. list.pop, dict.get).
-- Jedi resolves these against typeshed stub files, which strip docstrings, so
-- pylsp's LSP hover is empty for them even though the real CPython objects have
-- docstrings. This provider shells out to the real interpreter and reads
-- __doc__ directly off builtins + common container types, bypassing jedi.

local PY_SNIPPET = [==[
import re, sys, io, builtins

word = sys.argv[1]
candidates = []

if hasattr(builtins, word):
    candidates.append(getattr(builtins, word))

for typ in (list, dict, str, set, tuple, frozenset, bytes, bytearray, int, float):
    if hasattr(typ, word):
        candidates.append(getattr(typ, word))

def sanitize(line):
    # de-indent (docstrings often have 4+ space indents, which markdown
    # treats as a code block) and escape markdown special chars so raw
    # docstring prose (e.g. "*args", "_private_") isn't misparsed as
    # emphasis/code by the markdown treesitter renderer.
    return re.sub(r"([`*_\[\]])", r"\\\1", line.strip())

seen = set()
out = io.StringIO()
found = False
for obj in candidates:
    doc = getattr(obj, "__doc__", None)
    if doc and doc not in seen:
        seen.add(doc)
        qualname = getattr(obj, "__qualname__", word)
        out.write("### " + str(qualname) + "\n\n")
        for line in doc.split("\n"):
            out.write(sanitize(line) + "\n")
        out.write("\n")
        found = True

print(out.getvalue() if found else ("no docstring found for: " + word))
]==]

--- @param _params Hover.Provider.Params
--- @param done fun(result?: Hover.Provider.Result)
local function execute(_params, done)
  local word = vim.fn.expand("<cword>")
  if word == "" then
    done()
    return
  end

  local ok, result = pcall(function()
    return vim.system({ "python3", "-c", PY_SNIPPET, word }, { text = true }):wait()
  end)

  local output = ok and result and result.stdout or nil

  if not output or output:match("^%s*$") or output:match("^%s*no docstring found") then
    done()
    return
  end

  done({ lines = vim.split(output, "\n"), filetype = "markdown" })
end

--- @type Hover.Provider
return {
  name = "PyDoc",
  priority = 90,
  enabled = function(bufnr)
    return vim.bo[bufnr].filetype == "python"
  end,
  execute = execute,
}
