if not vim.g.jeff_enable_dirbuf then
  return {}
end

return {
  "elihunter173/dirbuf.nvim",
  config = function()
    vim.keymap.set('n', '<leader>db', ':Dirbuf<CR>', { desc = "Open directory buffer" })
  end
}
