local null_ls = require("null-ls")

return {
  sources = {null_ls.builtins.formatting.gofumpt, null_ls.builtins.formatting.goimports,
             null_ls.builtins.formatting.prettier.with({
    filetypes = {"svelte", "javascript", "typescript", "css", "scss", "json"}
  })}
}
