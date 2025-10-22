if not vim.g.jeff_enable_kulala then
  return {}
end

return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>rs", desc = "Send request" },
    { "<leader>ra", desc = "Send all requests" },
    { "<leader>rb", desc = "Open scratchpad" },
  },
  ft = {"http", "rest"},
  opts = {
    global_keymaps = false,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
  },
}
