if not vim.g.jeff_enable_smear then
  return {}
end

return {
  "sphamba/smear-cursor.nvim",
  opts = { smear_between_neighbor_lines = false },
}
