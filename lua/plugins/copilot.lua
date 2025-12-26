if not vim.g.jeff_enable_ai then
  return {}
end

return {
  "github/copilot.vim",
  config = function()
    vim.keymap.set('i', '<C-l>', 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false
    })
    vim.keymap.set('n', '<leader>ace', '<cmd>Copilot enable<CR>', { desc = "Enable copilot" })
    vim.keymap.set('n', '<leader>acd', '<cmd>Copilot disable<CR>', { desc = "Disable copilot" })
    vim.keymap.set({ 'n', 'i' }, '<leader>acs', '<cmd>Copilot panel<CR>', { desc = "Show copilot panel" })
  end
}
