return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    focus = true,
    modes = {
      diagnostics = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 1,
        },
        groups = {
          { "filename", format = "{file_icon} {basename:Title} {count}" },
        }
      }
    },
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "|  ",
      }
    }
  },
}
