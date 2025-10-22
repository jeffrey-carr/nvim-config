if not vim.g.jeff_enable_sidekick then
  return {}
end

return {
  "folke/sidekick.nvim",
  config = function()
    require("sidekick").setup({})
  end
}
