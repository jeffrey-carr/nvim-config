-- Misc
vim.keymap.set('n', '<leader>cb', ':bd<CR>', { desc = "Close buffer" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true })
vim.keymap.set('n', '<leader>tt', function()
  vim.cmd('botright new')
  vim.cmd("resize " .. math.floor(vim.o.lines / 3)) -- resize to 1/3 of screen height
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { desc = "Toggle terminal" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rh', ':noh<CR>', { desc = "Remove search highlights" })

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
vim.keymap.set('n', '<leader>rc', copy_github_permalink, { desc = "Copy GitHub permalink" })
if vim.g.jeff_enable_gitsigns then
  local gitsigns = require('gitsigns')
  vim.keymap.set('n', '<leader>gb', function()
    gitsigns.blame_line({ full = true })
  end, { desc = "Git blame line" })
  -- vim.keymap.set('n', '<leader>gf', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = "Git blame file" })
end

-- Window management
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move focus to right pane" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move focus to left pane" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move focus to above pane" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move focus to below pane" })
vim.keymap.set('n', '<leader>s', function()
  vim.cmd('vsplit')
  vim.cmd('wincmd l')
end, { desc = "Vertical split" })
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = "Horizontal split " })

-- Testing
-- local function find_nearest_test_func()
--   local cursor = vim.api.nvim_win_get_cursor(0)[1]
--   local lines = vim.api.nvim_buf_get_lines(0, 0, cursor, false)
--   for i = #lines, 1, -1 do
--     local line = lines[i]
--     local name = line:match("^func%s+(Test%w+)")
--     if name then return name end
--   end
--   return nil
-- end
--
-- local function find_module_root()
--   local dir = vim.fn.expand("%:p:h")
--   while dir ~= "/" do
--     if vim.fn.filereadable(dir .. "/go.mod") == 1 then
--       return dir
--     end
--     dir = vim.fn.fnamemodify(dir, ":h")
--   end
--   return nil
-- end
--
-- local function get_go_import_path()
--   local file_path = vim.api.nvim_buf_get_name(0)
--   local file_dir = vim.fn.fnamemodify(file_path, ":h")
--   local mod_root = find_module_root()
--   if not mod_root then
--     error("Could not find go.mod root")
--   end
--
--   -- read module name from go.mod
--   local lines = vim.fn.readfile(mod_root .. "/go.mod")
--   local module_line = vim.tbl_filter(function(line)
--     return line:match("^module%s+")
--   end, lines)[1]
--
--   local mod_name = module_line:match("^module%s+(.+)")
--   if not mod_name then
--     error("Could not extract module name from go.mod")
--   end
--
--   -- compute relative path from module root to file directory
--   local rel_path = vim.fn.fnamemodify(file_dir, ":." .. mod_root)
--   return mod_name .. "/" .. rel_path, mod_root
-- end
--
-- local function run_nearest_go_test()
--   local test_func = find_nearest_test_func()
--   if not test_func then
--     vim.notify("No test function found above cursor.", vim.log.levels.ERROR)
--     return
--   end
--
--   local pkg_path, cwd = get_go_import_path()
--   local cmd = "go test -timeout 30s -run ^" .. test_func .. "$ " .. pkg_path
--
--   vim.cmd("vsplit")
--   vim.cmd("wincmd l")
--   local width = math.floor(vim.o.columns * 0.3)
--   vim.cmd("vertical resize " .. width)
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_win_set_buf(0, buf)
--
--   vim.fn.termopen(cmd)
-- end
-- vim.keymap.set("n", "<leader>rt", run_nearest_go_test, { desc = "Run the nearest test", noremap = true, silent = true })

-- Folds all methods to their highest level (thanks Brian)
vim.keymap.set("n", "zf0", function()
  -- save & switch to manual foldmethod (zf only works with manual/marker)
  local win = vim.api.nvim_get_current_win()
  local old_fm = vim.wo[win].foldmethod
  local old_fe = vim.wo[win].foldenable
  vim.wo[win].foldmethod = "manual"
  vim.wo[win].foldenable = true

  -- grab the cursor so we can restore it at the end
  local cursor = vim.api.nvim_win_get_cursor(0)

  -- clear existing manual folds
  vim.cmd.normal({ args = { "zE" }, bang = true })

  local function fold_node(node)
    -- get the node's range (start row/col, end row/col)
    -- both of these are 0-based, but neovim is 1-based for line numbers and 0-based for columns (gross)
    local sr, sc, er, ec = node:range()
    -- go to the start of the range
    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    -- select to the end of the range
    vim.cmd.normal({ args = { "v" }, bang = true })
    vim.api.nvim_win_set_cursor(0, { er + 1, ec - 1 })
    -- create the fold
    vim.cmd.normal({ args = { "zf" }, bang = true })
  end

  local ok, result = pcall(function()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if not lang then
      vim.notify("zf0: no treesitter lang for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
      return
    end

    local parser = vim.treesitter.get_parser(0, lang)
    if not parser then
      vim.notify("zf0: no treesitter parser for lang " .. lang, vim.log.levels.ERROR)
      return
    end
    local tree = parser:parse()[1]
    local root = tree:root()

    local query = vim.treesitter.query.parse(
      lang,
      [[
        ;; imports
        ((import_declaration) @import)

        ;; struct
        (type_spec (struct_type) @s_body)

        ;; interface
        (type_spec (interface_type) @i_body)

        ;; functions
        ((function_declaration) @f_body)

        ;; methods
        ((method_declaration) @m_body)
      ]]
    )
    for _, node, _ in query:iter_captures(root, 0, 0, -1) do
      fold_node(node)
    end
  end)
  if not ok then
    vim.notify("zf0: treesitter fold attempt failed: " .. result, vim.log.levels.ERROR)
  end

  -- restore prior fold settings
  vim.wo[win].foldmethod = old_fm
  vim.wo[win].foldenable = old_fe

  -- restore cursor
  vim.api.nvim_win_set_cursor(0, cursor)
end, { desc = "fold to the 0th degree" })

-- Generate mocks for current interface
-- TODO: this assumes that an interface is defined on a single line, which
-- isn't always true because of generics
local function get_interface_under_cursor()
  -- look for the next line that matches "type Xxx interface {"
  -- and return Xxx
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cursorRow = vim.api.nvim_win_get_cursor(0)[1]
  for i = cursorRow, #lines do
    local line = lines[i]
    local name = line:match("^%s*type%s+([%w_]+)%s+interface%s*{")
    if name then
      return name
    end
  end
  return nil
end
vim.keymap.set("n", "<leader>gM",
function()
  local interface_name = get_interface_under_cursor()
  if not interface_name then
    vim.notify("no interface found under/after cursor", vim.log.levels.ERROR)
    return
  end

  -- TODO: this is cleaner if it all filters on package name
  local cmd = string.format("pipenv run inv generate-mocks --mock-name=%s", interface_name)
  vim.notify(string.format("running: %s", cmd), vim.log.levels.INFO)
  vim.fn.system(cmd)
  local exit_code = vim.v.shell_error
  if exit_code ~= 0 then
    vim.notify("mock generation failed, exit code " .. exit_code, vim.log.levels.ERROR)
    return
  end
  vim.notify("mock generated for interface " .. interface_name, vim.log.levels.INFO)
end, { desc = "Generate mock for current interface" })

