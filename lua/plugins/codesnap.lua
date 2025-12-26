if not vim.g.jeff_enable_codesnap then
  return {}
end

return {
  "mistricky/codesnap.nvim",
  build = "make",
  config = function()
    require('codesnap').setup({
      has_breadcrumbs = false,
      has_line_number = true,
      mac_window_bar = false,
      watermark = "",
      bg_theme = 'sea',
      bg_padding = 0,
    })

    vim.keymap.set('v', '<leader>cs', ':CodeSnap<CR>', { desc = "Take screenshot (CodeSnap)" })
  end
}
