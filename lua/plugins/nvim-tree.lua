return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require('nvim-tree').setup({
      hijack_directories = { enable = false },
      update_focused_file = { enable = true },
    })
  end
}
