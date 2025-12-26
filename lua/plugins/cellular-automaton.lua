if not vim.g.jeff_enable_cellular_automaton then
  return {}
end

return {
  "eandrju/cellular-automaton.nvim",
  config = function()
    vim.keymap.set('n', '<leader>gu', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = "Give up" })
  end
}
