if not vim.g.jeff_enable_bufferline then
  return{}
end

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({})
  end
}
