if not vim.g.jeff_enable_hologram then
  return {}
end

return {
  "edluffy/hologram.nvim",
  config = function()
    require('hologram').setup({})
  end
}
