if not vim.g.jeff_enable_autotag then
  return {}
end

return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({})
  end
}
