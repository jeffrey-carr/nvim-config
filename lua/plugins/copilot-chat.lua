if not vim.g.jeff_enable_copilot_chat then
  return {}
end

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  opts = {
    auto_insert_mode = true,
  },
}
