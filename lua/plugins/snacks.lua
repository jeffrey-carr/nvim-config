if not vim.g.jeff_enable_snacks then
  return {}
end

return {
  "folke/snacks.nvim",
  priority = 1001,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true, example = "github" },
    explorer = { enabled = false },
    image = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    util = { enabled = true },
    words = { enabled = true },
  }
}
