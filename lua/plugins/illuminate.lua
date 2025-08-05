-- Highlight all instances of word under cursor
if not vim.g.jeff_enable_illuminate then
  return {}
end

return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",    -- lazy-load after startup
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
