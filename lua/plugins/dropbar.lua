if not vim.g.jeff_enable_dropbar then
  return {}
end

return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  config = function()
    require('dropbar')
  end
}
