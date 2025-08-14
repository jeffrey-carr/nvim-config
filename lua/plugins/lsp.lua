if not vim.g.jeff_enable_lsp then
  return {}
end

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

      -- put this helper near the top of the config()
      local function lsp_format(bufnr)
        local has_null = false
        for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
          if c.name == "null-ls" then
            has_null = true
            break
          end
        end
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = has_null
              and function(c) return c.name == "null-ls" end
              or function(c) return c.name ~= "null-ls" end,
        })
      end

      -- replace your on_attach with this
      local on_attach = function(client, bufnr)
        -- don't let formatexpr override LSP formatting
        vim.bo[bufnr].formatexpr = ""

        -- ✅ use supports_method, not server_capabilities
        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function() lsp_format(bufnr) end,
            desc = "Format on save (prefers null-ls when present)",
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
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = { unusedparams = true },
          }
        }
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
