-- Misc
vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = "Comment current line" })
vim.keymap.set('n', '<leader>cb', ':bd<CR>', { desc = "Close buffer" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('n', '<leader>t', ':Themery<CR>', { desc = "Change themes" })
vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true })
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>', { desc = "LazyGit" })
vim.keymap.set('n', '<leader>rl', ':LspRestart<CR>', { desc = "Reload buffer from disk" })
vim.keymap.set('v', '<leader>cs', ':CodeSnap<CR>', { desc = "Take screenshot (CodeSnap)" })
vim.keymap.set('n', '<leader>oc', function()
  vim.cmd('botright new')
  vim.cmd("resize " .. math.floor(vim.o.lines / 3)) -- resize to 1/3 of screen height
  vim.cmd('terminal')
  -- Start in Insert mode
  vim.cmd('startinsert')
end, { desc = "Open console" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set('n', '<leader>fr', telescope.lsp_references, { desc = "Telescope find references" })
vim.keymap.set('n', '<leader>fd', telescope.lsp_definitions, { desc = "Telescope find definitions" })
vim.keymap.set('n', '<leader>fi', telescope.lsp_implementations, { desc = "Telescope find implementation" })
vim.keymap.set('n', '<leader>fs', telescope.lsp_document_symbols, { desc = "Telescope find symbols" })
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
-- vim.keymap.set('n', '<leader>s', ':vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>s', function()
  vim.cmd('vsplit')
  vim.cmd('wincmd l')
end, { desc = "Vertical split" })
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = "Horizontal split " })
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
vim.keymap.set('n', '<leader>bs', function()
  -- If only one window, do nothing
  if vim.fn.winnr('$') < 2 then
    vim.notify("Only one window open.")
    return
  end

  -- Close all but current window
  vim.cmd('only')
end, { desc = "Unsplits vertically split buffers into separate tabs" })

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
    vim.notify("No test function found above cursor.")
    return
  end

  local pkg_path, cwd = get_go_import_path()
  vim.notify(cwd)
  local cmd = "go test -timeout 30s -run ^" .. test_func .. "$ " .. pkg_path

  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  local width = math.floor(vim.o.columns * 0.3)
  vim.cmd("vertical resize " .. width)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)

  vim.fn.termopen(cmd)
end

vim.keymap.set("n", "<leader>rt", run_nearest_go_test, { desc = "Run the nearest test", noremap = true, silent = true })
