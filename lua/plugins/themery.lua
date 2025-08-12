if not vim.g.jeff_enable_themery then
  return {}
end

return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "rose-pine",
        "nightfox",
        "duskfox",
        "nordfox",
        "terafox",
        "carbonfox",
        "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "tokyonight",
        "kanagawa-wave",
        "kanagawa-dragon",
        "kanagawa-lotus",
        "neofusion",
        "aurora",
        "spaceduck",
        "everforest",
        "everforest-light",
      },
      livePreview = true,
      before_load = function(theme_name)
        if theme_name == "everforest-light" then
          vim.o.background = "light"
          vim.g.everforest_background = "soft" -- can be "hard", "medium", "soft"
          vim.cmd.colorscheme("everforest")
          return false
        elseif theme_name == "everforest" then
          vim.o.background = "dark"
          vim.g.everforest_background = "medium"
        end
      end,
    })
  end
}
