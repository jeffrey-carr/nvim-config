# Copilot
local copilot_enabled_config = vim.fn.stdpath('data') .. '/copilot_enabled_config.lua'
local ok, result = pcall(loadfile, copilot_enabled_config)
if ok and result then
  local success, value = pcall(result)
  vim.g.copilot_enabled = success and value
  vim.notify("Loaded copilot_enabled_config.lua with value: " .. tostring(success and value))
else
  vim.notify("Could not load copilot_enabled_config.lua, defaulting to true")
  vim.g.copilot_enabled = true
end

-- Ensure it's applied to the buffer
vim.b.copilot_enabled = vim.g.copilot_enabled
