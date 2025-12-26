if not vim.g.jeff_enable_telescope then
  return {}
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "mocks/",
          "mock_*",
        }
      },
    })
    require('telescope').load_extension('ui-select')
    local telescope = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Telescope find files" })
    vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set('n', '<leader>fr', telescope.lsp_references, { desc = "Telescope find references" })
    vim.keymap.set('n', '<leader>fd', telescope.lsp_definitions, { desc = "Telescope find definitions" })
    vim.keymap.set('n', '<leader>fi', telescope.lsp_implementations, { desc = "Telescope find implementation" })
    vim.keymap.set('n', '<leader>fs', telescope.lsp_document_symbols, { desc = "Telescope find symbols" })
    vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = "Telescope buffers" })
    vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = "Telescope help tags" })

    vim.keymap.set('n', '<leader>bm', function()
      local splitright = vim.o.splitright
      vim.o.splitright = true
      vim.cmd('vsplit')
      vim.o.splitright = splitright

      -- Focus on new window
      local win = vim.api.nvim_get_current_win()

      -- Open telescope buffers in this window
      require('telescope.builtin').buffers({
        attach_mappings = function(_, map)
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          map('i', '<CR>', function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.api.nvim_win_set_buf(win, selection.bufnr)
          end)
          map('i', '<PageUp>', actions.preview_scrolling_up)
          map('i', '<PageDown>', actions.preview_scrolling_down)
          map('n', '<PageUp>', actions.preview_scrolling_up)
          map('n', '<PageDown>', actions.preview_scrolling_down)

          return true
        end,
        previewer = true,
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.5,
          height = 0.9,
        }
      })
    end, { desc = "Vertical split and open buffer picker with preview" }) -- Get list of buffers
  end
}
