if not vim.g.jeff_enable_luarocks then
  return {}
end

return {
  "vhyrro/luarocks.nvim",
  priority = 1000,
  config = true,
}
