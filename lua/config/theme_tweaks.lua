-- This is a comment
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.defer_fn(function()
      if vim.g.colors_name == "spaceduck" then
        vim.api.nvim_set_hl(0, "Comment", { fg = "#afa1e1", italic = true })
      end
    end, 0)
  end,
})

vim.api.nvim_exec_autocmds("ColorScheme", {})
