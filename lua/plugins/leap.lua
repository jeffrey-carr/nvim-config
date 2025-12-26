if not vim.g.jeff_enable_leap then
  return {}
end

return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  opts = {},
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
  end
}
