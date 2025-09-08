if not vim.g.jeff_enable_satellite then
  return {}
end

return {
  "lewis6991/satellite.nvim",
  config = function()
    require("satellite").setup({})
  end,
}
