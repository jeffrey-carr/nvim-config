vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Required for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})

-- Temporary debugging
vim.lsp.set_log_level("debug")

require("jeff.plugin_manager")
require("jeff.lazy_init")
require("jeff.set")
require("jeff.config_manager")
require("jeff.remap")
