if not vim.g.jeff_enable_treesitter_context then
  return {}
end

return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufRead',
  config = function()
    require('treesitter-context').setup({
      separator = "-",
    })
    vim.cmd("highlight! link TreesitterContextLineNumber LineNrAbove")
    vim.cmd("highlight! link TreesitterContextSeparator Comment")
  end
}
