local git_email = vim.fn.system('git config --get user.email'):gsub('%s+', '')
    vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
local is_home = git_email == 'jeffrey.carr98@gmail.com'
local is_work = git_email == 'jeff@getredcircle.com'

local default_enabled = true
vim.g.jeff_enable_autoclose = default_enabled
vim.g.jeff_enable_bufferline = default_enabled
vim.g.jeff_enable_codesnap = default_enabled
vim.g.jeff_enable_completion = default_enabled
vim.g.jeff_enable_dirbuf = default_enabled
vim.g.jeff_enable_gitsigns = true
vim.g.jeff_enable_illuminate = false
vim.g.jeff_enable_indent_blankline = default_enabled
vim.g.jeff_enable_lazygit = default_enabled
vim.g.jeff_enable_leap = default_enabled
vim.g.jeff_enable_lsp = default_enabled
vim.g.jeff_enable_mini = default_enabled
vim.g.jeff_enable_notify = default_enabled
vim.g.jeff_enable_nvim_tree = default_enabled
vim.g.jeff_enable_surround = default_enabled
vim.g.jeff_enable_telescope = default_enabled
vim.g.jeff_enable_treesitter = default_enabled
vim.g.jeff_enable_trouble = default_enabled
vim.g.jeff_enable_which_keys = default_enabled
vim.g.jeff_enable_windowswap = default_enabled
vim.g.jeff_enable_treesitter_context = default_enabled
vim.g.jeff_enable_grug_far = default_enabled
vim.g.jeff_enable_theme_hub= default_enabled
vim.g.jeff_enable_smear = default_enabled
vim.g.jeff_enable_satellite = default_enabled
vim.g.jeff_enable_luarocks = default_enabled
vim.g.jeff_enable_snacks = default_enabled
vim.g.jeff_enable_pineapple = default_enabled
vim.g.jeff_enable_markview = default_enabled
vim.g.jeff_enable_go_testing = default_enabled
vim.g.jeff_enable_gopher = default_enabled
vim.g.jeff_enable_ai = default_enabled
vim.g.jeff_enable_goto_preview = default_enabled

-- Enable/disable per profile
if is_work then
  vim.notify("Logged in as work.")
elseif is_home then
  vim.notify("Logged in as home. Happy coding :)")
else
  vim.notify("Not loggged in. AI agents disabled")
end
