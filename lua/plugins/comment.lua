if not vim.g.jeff_enable_comment then
  return{}
end

return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      mappings = false
    })
  end
}
