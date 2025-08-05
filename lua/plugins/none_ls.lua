if not vim.g.jeff_enable_none_ls then
  return {}
end

return {
  'nvimtools/none-ls.nvim',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("plugins.formatting.null_ls")
  end,
}
