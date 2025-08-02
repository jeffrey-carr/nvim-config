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
      lspconfig.lua_ls.setup({
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
      lspconfig.ts_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.svelte.setup({})
      lspconfig.cssls.setup({})
      lspconfig.gopls.setup({})
      lspconfig.zls.setup({})
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  }
}
