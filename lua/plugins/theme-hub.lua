if not vim.g.jeff_enable_theme_hub then
  return {}
end

return {
  "erl-koenig/theme-hub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "rktjmp/lush.nvim",
  },
  config = function()
    require("theme-hub").setup({
      persistent = true,
    })

    vim.keymap.set('n', '<leader>th', ':ThemeHub<CR>', { desc = "Open Theme Hub" })
  end
}
