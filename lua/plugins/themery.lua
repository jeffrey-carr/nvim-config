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
        "github_dark",
        "github_light",
        "github_dark_dimmed",
        "github_light_high_contrast",
      },
      livePreview = true,
    })
  end
}
