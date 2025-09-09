if not vim.g.jeff_enable_smear then
  return {}
end

return {
  "sphamba/smear-cursor.nvim",
  opts = {
    min_horizontal_distance_smear = 5,
    min_vertical_distance_smear = 5,
    smear_to_cmd = false,
    max_length = 15,
    time_interval = 7,
  },
}
