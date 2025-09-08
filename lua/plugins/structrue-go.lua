if not vim.g.jeff_enable_structrue_go then
  return {}
end

return {
  "crusj/structrue-go.nvim",
  branch = "main",
  config = function()
    require("structrue-go").setup({
      number = "rnu", -- relative line numbers
      keymap = {},
    })
  end,
}
