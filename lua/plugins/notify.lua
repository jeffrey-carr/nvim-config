if not vim.g.jeff_enable_notify then
  return {}
end

return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    vim.notify = notify
  end
}
