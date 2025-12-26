if not vim.g.jeff_enable_marks  then
  return {}
end

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("marks").setup(opts)

    vim.keymap.set("n", "<leader>mt", "<cmd>MarksToggleSigns<CR>", { desc = "Toggle mark" })
    vim.keymap.set("n", "<leader>mlf", "<cmd>MarksListBuf<CR>", { desc = "List marks in buffer" })
    vim.keymap.set("n", "<leader>mla", "<cmd>MarksListAll<CR>", { desc = "List all marks" })
    vim.keymap.set("n", "<leader>mn", "<Plug>(marks-next)", { desc = "Set next mark" })
  end,
}

