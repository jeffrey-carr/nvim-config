if not vim.g.jeff_enable_gopher then
  return {}
end

-- leader 'gt'
return {
  "olexsmir/gopher.nvim",
  ft = "go",
  config = function(_, opts)
    local gopher = require("gopher")
    gopher.setup(opts)
    local gconfig = require("gopher.config")

    -- Since we use different configs for JSON vs YAML,
    -- we need to modify the config value when we use it
    vim.keymap.set('n', '<leader>gtj', function()
        gopher.setup({ gotag = { transform = 'camelcase' }})
        vim.cmd("GoTagAdd json")
      end, { desc = "Add JSON struct tags" })
    vim.keymap.set('n', '<leader>gty', function()
        gopher.setup({ gotag = { transform = 'snakecase' }})
        vim.cmd("GoTagAdd yaml")
    end, { desc = "Add YAML struct tags" })
  end,
}
