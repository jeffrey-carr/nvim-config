local function lsp_format(bufnr)
  local has_null = false
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if c.name == "null-ls" then
      has_null = true; break
    end
  end
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = has_null and function(c) return c.name == "null-ls" end
        or function(c) return c.name ~= "null-ls" end,
  })
end

local on_attach = function(client, bufnr)
  vim.bo[bufnr].formatexpr = ""
  if client.supports_method("textDocument/formatting") then
    local group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function() lsp_format(bufnr) end,
      desc = "Format on save (prefers null-ls)",
    })
  end

  if client.config.root_dir then
    pcall(vim.cmd.cd, client.config.root_dir)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,

  cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
  root_markers = { "go.work", "go.mod", ".git" },

  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true
      }
    }
  }
})

vim.lsp.enable('gopls')
