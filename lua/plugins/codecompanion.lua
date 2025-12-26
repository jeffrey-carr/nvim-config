if not vim.g.jeff_enable_ai then
  return {}
end

-- Prefix a (for AI)
return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require('codecompanion').setup({
      interactions = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["file"] = {
              opts = {
                provider = "telescope",
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      display = {
        chat = {
          window = {
            sticky = true,
            width = 0.33,
          }
        }
      }
    })
    vim.keymap.set('n', '<leader>aoc', '<cmd>CodeCompanionChat <CR>', { desc = "Open AI chat" })
    vim.keymap.set({ 'n', 'v' }, '<leader>aoi', '<cmd>CodeCompanion <CR>', { desc = "Run AI inline" })
    vim.keymap.set('n', '<leader>aoa', '<cmd>CodeCompanionActions <CR>', { desc = "Open AI command palette" })
  end
}