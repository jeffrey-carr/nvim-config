if not vim.g.jeff_enable_which_keys then
  return {}
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern"
  }
}
