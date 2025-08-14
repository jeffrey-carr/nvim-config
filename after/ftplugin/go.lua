local buf = vim.api.nvim_get_current_buf()
local grp = vim.api.nvim_create_augroup("GoFormat." .. buf, { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = grp,
  buffer = buf,
  desc = "Go: format on save via gopls",
  callback = function()
    -- Force gopls; ignore null-ls for Go
    vim.lsp.buf.format({
      async = false,
      filter = function(c) return c.name == "gopls" end,
    })
  end,
})
