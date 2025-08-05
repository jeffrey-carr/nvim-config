if not vim.g.jeff_enable_telescope then
  return {}
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "mocks/",
          "mock_*",
        }
      }
    })
  end
}
