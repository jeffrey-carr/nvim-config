if not vim.g.jeff_enable_pineapple then
  return {}
end

return {
  "CWood-sdf/pineapple",
  dependencies = require("jeff.pineapple"),
  opts = {
    installedRegistry = "jeff.pineapple",
    colorschemeFile = "after/plugin/theme.lua",
  },
  cmd = "Pineapple",
  init = function()
    vim.keymap.set('n', '<leader>tt', '<cmd>Pineapple<CR>', { desc = "Open Pineapple" })
  end
}
