if not vim.g.jeff_enable_gp then
  return {}
end

return {
  'robitx/gp.nvim',
  config = function()
    require('gp').setup({
      open_api_key = { "cat", "~/.config/api_key.txt" },
    })
  end
}
