local git_email = vim.fn.system('git config --get user.email'):gsub('%s+', '')
local is_home = git_email == 'jeffrey.carr98@gmail.com'
local is_work = git_email == 'jeff@getredcircle.com'

local default_enabled = true
vim.g.jeff_enable_autoclose = default_enabled
vim.g.jeff_enable_autotag = default_enabled
vim.g.jeff_enable_bufferline = default_enabled
vim.g.jeff_enable_codesnap = default_enabled
vim.g.jeff_enable_comment = default_enabled
vim.g.jeff_enable_completion = default_enabled
vim.g.jeff_enable_copilot_chat = default_enabled
vim.g.jeff_enable_copilot = default_enabled
vim.g.jeff_enable_dirbuf = default_enabled
vim.g.jeff_enable_prettier = default_enabled
vim.g.jeff_enable_gitsigns = default_enabled
vim.g.jeff_enable_illuminate = default_enabled
vim.g.jeff_enable_indent_blankline = default_enabled
vim.g.jeff_enable_lazygit = default_enabled
vim.g.jeff_enable_leap = default_enabled
vim.g.jeff_enable_lsp = default_enabled
vim.g.jeff_enable_mini = default_enabled
vim.g.jeff_enable_none_ls = default_enabled
vim.g.jeff_enable_notify = default_enabled
vim.g.jeff_enable_nvim_tree = default_enabled
vim.g.jeff_enable_surround = default_enabled
vim.g.jeff_enable_telescope = default_enabled
vim.g.jeff_enable_themery = default_enabled
vim.g.jeff_enable_treesitter = default_enabled
vim.g.jeff_enable_trouble = default_enabled
vim.g.jeff_enable_which_keys = default_enabled
vim.g.jeff_enable_windowswap = default_enabled
vim.g.jeff_enable_treesitter_context = default_enabled
vim.g.jeff_enable_grug_far = default_enabled

-- Enable/disable per profile
if is_work then
  vim.g.jeff_enable_copilot_chat = false
  vim.g.jeff_enable_prettier = false
  vim.notify("Logged in as work. Copilot chat and Prettier disabled.")
elseif is_home then
  vim.notify("Logged in as home. All plugins enabled. Happy coding :)")
else
  vim.g.jeff_enable_copilot = false
  vim.g.jeff_enable_copilot_chat = false
  vim.notify("Not loggged in. Copilot and Copilot chat disabled.")
end
