if not vim.g.jeff_enable_lsp then
  return {}
end

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "marksman",
        "zls"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp_custom.lspconfig")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      return require("plugins.lsp_custom.null-ls")
    end,
  }
}

