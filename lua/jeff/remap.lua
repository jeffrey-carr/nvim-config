-- Misc
vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = "Comment current line" })
vim.keymap.set('n', '<leader>cb', ':bd<CR>', { desc = "Close buffer" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('n', '<leader>t', ':Themery<CR>', { desc = "Change themes" })
vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true })
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>', { desc = "LazyGit" })

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set('n', '<leader>fr', telescope.lsp_references, { desc = "Telescope find references" })
vim.keymap.set('n', '<leader>fd', telescope.lsp_definitions, { desc = "Telescope find definitions" })
vim.keymap.set('n', '<leader>fi', telescope.lsp_implementations, { desc = "Telescope find implementation" })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = "Telescope help tags" })

-- Git
local function copy_github_permalink()
  -- Get absolute path to current file
  local file = vim.fn.expand('%:p')
  local line = vim.fn.line('.')

  -- Get Git info
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local repo = vim.fn.system('git config --get remote.origin.url')
    :gsub('%.git\n', '')
    :gsub('git@github.com:', 'https://github.com/')
    :gsub('\n', '')
  local commit = vim.fn.system('git rev-parse HEAD'):gsub('\n', '')

  -- Relative path from Git root
  local rel_path = file:sub(#git_root + 2) -- +2 to account for trailing slash

  -- Construct URL
  local url = string.format("%s/blob/%s/%s#L%d", repo, commit, rel_path, line)

  -- Copy to clipboard
  vim.fn.setreg('+', url)
  vim.notify("📎 Copied remote link to clipboard", vim.log.levels.INFO)
end
local gitsigns = require('gitsigns')
vim.keymap.set('n', '<leader>rc', copy_github_permalink, { desc = "Copy GitHub permalink" })
vim.keymap.set('n', '<leader>gb', function()
  gitsigns.blame_line({ full = true })
end, { desc = "Git blame line" })
vim.keymap.set('n', '\\gf', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = "Git blame file" })

-- Window management
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move focus to right pane" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move focus to left pane" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move focus to above pane" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move focus to below pane" })
vim.keymap.set('n', '<leader>s', ':vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = "Horizontal split "})
vim.keymap.set('n', '<leader>vb', function()
  local buf_list = vim.fn.getbufinfo({ buflisted = 1 })
  local choices = {}
  for _, buf in ipairs(buf_list) do
    table.insert(choices, buf.bufnr .. ': ' .. buf.name)
  end

  vim.ui.select(choices, { prompt = 'Select buffer to open in vertical split:' }, function(choice)
    if not choice then return end
    local bufnr = tonumber(choice:match('^(%d+):'))
    vim.cmd('vsplit')
    vim.api.nvim_set_current_buf(bufnr)
  end)
end, { desc = "Vertical split with buffer select" })

-- Directory
vim.keymap.set('n', '<leader>db', ':Dirbuf<CR>', { desc = "Open directory buffer" })
vim.keymap.set('n', '<leader>ot', ':NvimTreeOpen<CR>', { desc = "Open directory tree" })
vim.keymap.set('n', '<leader>ct', ':NvimTreeClose<CR>', { desc = "Close directory tree" })

-- Trouble
vim.keymap.set('n', '<leader>oe', ':Trouble diagnostics<CR>', { desc = "Show Trouble diagnostics" })
vim.keymap.set('n', '<leader>ce', ':Trouble close<CR>', { desc = "Close Trouble diagnostics" })

-- Testing
local function find_nearest_test_func()
  local cursor = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, cursor, false)
  for i = #lines, 1, -1 do
    local line = lines[i]
    local name = line:match("^func%s+(Test%w+)")
    if name then return name end
  end
  return nil
end

local function find_module_root()
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/go.mod") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

local function get_go_import_path()
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_dir = vim.fn.fnamemodify(file_path, ":h")
  local mod_root = find_module_root()
  if not mod_root then
    error("Could not find go.mod root")
  end

  -- read module name from go.mod
  local lines = vim.fn.readfile(mod_root .. "/go.mod")
  local module_line = vim.tbl_filter(function(line)
    return line:match("^module%s+")
  end, lines)[1]

  local mod_name = module_line:match("^module%s+(.+)")
  if not mod_name then
    error("Could not extract module name from go.mod")
  end

  -- compute relative path from module root to file directory
  local rel_path = vim.fn.fnamemodify(file_dir, ":." .. mod_root)
  return mod_name .. "/" .. rel_path, mod_root
end

local function run_nearest_go_test()
  local test_func = find_nearest_test_func()
  if not test_func then
    print("No test function found above cursor.")
    return
  end

  local pkg_path, cwd = get_go_import_path()
  local cmd = "go test -timeout 30s -run ^" .. test_func .. "$ " .. pkg_path

  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  local width = math.floor(vim.o.columns * 0.3)
  vim.cmd("vertical resize " .. width)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)

  vim.fn.termopen(cmd)
end

vim.keymap.set("n", "<leader>rt", run_nearest_go_test, { noremap = true, silent = true })
