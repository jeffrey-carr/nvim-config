local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

local srcs = {}
if vim.g.jeff_enable_prettier then
  sources = formatting.prettier.with({
    filetypes = { "html", "css", "scss", "javascript", "typescript", "svelte", "json", "yaml", "markdown" },
  })
end

null_ls.setup({
  sources = srcs,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              return c.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})
