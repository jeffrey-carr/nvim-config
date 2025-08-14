local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

local sources = {}
if vim.g.jeff_enable_prettier then
  table.insert(sources, formatting.prettier.with({
    filetypes = { "html", "css", "scss", "javascript", "typescript", "svelte", "json", "yaml", "markdown" },
  }))
end

null_ls.setup({
  sources = sources,
})
