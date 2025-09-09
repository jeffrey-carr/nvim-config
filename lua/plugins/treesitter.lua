if not vim.g.jeff_enable_treesitter then
  return {}
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
 
    configs.setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "elixir",
        "javascript",
        "html",
        "python",
        "typescript",
        "java",
        "svelte",
        "css",
        "http",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
