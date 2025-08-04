return {
  "mistricky/codesnap.nvim",
  build = "make",
  config = function()
    require('codesnap').setup({
      has_breadcrumbs = true,
      has_line_number = true,
      watermark = "",
      bg_theme = 'sea',
      bg_padding = 0,
    })
  end
}
