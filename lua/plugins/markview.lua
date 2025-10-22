-- https://github.com/OXY2DEV/markview.nvim
if not vim.g.jeff_enable_markview then
  return {}
end

return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  config = function()
    require("markview").setup({})
  end,
}
