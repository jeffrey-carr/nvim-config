if not vim.g.jeff_enable_rest then
  return {}
end

return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
}

