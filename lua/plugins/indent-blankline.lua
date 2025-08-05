if not vim.g.jeff_enable_indent_blankline then
  return {}
end

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
}
