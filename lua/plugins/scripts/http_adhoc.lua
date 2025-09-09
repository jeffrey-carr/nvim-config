local M = {}

local function http_template()
  return table.concat({
    "### Simple GET",
    "GET https://httpbin.org/get",
    "Accept: application/json",
    "",
    "### Simple POST JSON",
    "POST https://httpbin.org/post",
    "Content-Type: application/json",
    "",
    "{",
    '  "hello": "world"',
    "}",
    "",
    "### Add more requests above/below; use `###` as separators",
    "",
  }, "\n")
end

local function find_scratch_buf()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(b)
       and vim.bo[b].buflisted
       and (vim.fn.getbufvar(b, "http_adhoc", 0) == 1) then
      return b
    end
  end
  return nil
end

-- Create (or return) the HTTP scratch buffer
local function get_or_create_scratch()
  local existing = find_scratch_buf()
  if existing then
    return existing
  end

  -- Create as LISTED (true), scratch (true)
  local buf = vim.api.nvim_create_buf(true, true)
  -- Mark for identification later
  pcall(vim.api.nvim_buf_set_var, buf, "http_adhoc", 1)

  -- Make it scratch-like but persistent in buffer list
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].undofile = false
  vim.bo[buf].modeline = false
  vim.bo[buf].filetype = "http"
  vim.bo[buf].expandtab = false
  vim.bo[buf].tabstop = 2
  vim.bo[buf].shiftwidth = 2

  -- Give it a friendly name so :b HTTP_ADHOC works
  vim.api.nvim_buf_set_name(buf, "HTTP_ADHOC")

  return buf
end

local function createScratch()
  local buf = get_or_create_scratch()
  vim.api.nvim_set_current_buf(buf)

  local lines = vim.split(http_template(), "\n", { plain = true })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

vim.api.nvim_create_user_command("HTTPAdhoc", function(opts)
  local cmd = (opts.fargs[1] or ""):lower()
  if cmd == "open" then
    createScratch()
  else
    vim.notify(string.format("[HTTPAdhoc] Unknown command: %s", cmd), vim.log.levels.ERROR)
  end
end, {
    nargs = 1,
    complete = function()
      return { "open" }
    end
})

return M
