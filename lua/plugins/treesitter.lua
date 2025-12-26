if not vim.g.jeff_enable_treesitter then
  return {}
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Required for neotest-golang
  lazy = false,
  build = ":TSUpdate",
  config = function()
    vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

    parsers = require("nvim-treesitter.parsers")
    local install = require("nvim-treesitter.install")
    local ensure_installed = {
      "go", "gomod", "lua", "vim",
      "markdown", "json", "javascript", "yaml"
    }
    local already_installed = require("nvim-treesitter.config").get_installed()
    local to_install = {}
    for _, lang in ipairs(ensure_installed) do
      if not vim.tbl_contains(already_installed, lang) then
        table.insert(to_install, lang)
      end
    end
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end
  end
}
