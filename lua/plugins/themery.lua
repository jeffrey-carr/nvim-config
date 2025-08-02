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
      },
      livePreview = true,
    })
  end
}
