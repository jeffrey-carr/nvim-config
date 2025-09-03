if not vim.g.jeff_enable_theme_hub then
  return {}
end

return {
  "erl-koenig/theme-hub.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("theme-hub").setup({
      persistent = true,
    })
  end
}
