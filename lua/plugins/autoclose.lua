if not vim.g.jeff_enable_autoclose then
  return {}
end

return {
  "m4xshen/autoclose.nvim",
  config = function()
    require("autoclose").setup()
  end
}
