if not vim.g.jeff_enable_lualine then
  return {}
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({})
  end
}
