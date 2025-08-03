return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "svelte",
          "cssls",
          "gopls",
          "ts_ls",
          "zls",
          "marksman",
        },
        automatic_installation = true
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Define on_attach function at the top
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('LspFormat', { clear = false }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(lsp_client)
                  return lsp_client.name == "gopls"
                    or lsp_client.name == "lua_ls"
                    or lsp_client.name == "null-ls"
                end,
              })
            end,
          })
        end
      end

      -- Setup LSP servers
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
      })
      
      lspconfig.html.setup({
        on_attach = on_attach,
      })
      
      lspconfig.svelte.setup({
        on_attach = on_attach,
      })
      
      lspconfig.cssls.setup({
        on_attach = on_attach,
      })
      
      lspconfig.gopls.setup({
        on_attach = on_attach,
      })
      
      lspconfig.zls.setup({
        on_attach = on_attach,
      })
      
      lspconfig.marksman.setup({
        on_attach = on_attach,
      })
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  }
}
