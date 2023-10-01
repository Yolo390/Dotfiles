local M = {}

---vim.keymap.set
---@param mode string|table
---@param key string
---@param cmd string|function
---@param desc string
---@param opts table|nil
function M.map(mode, key, cmd, desc, opts)
  opts = opts or {}
  opts.desc = desc

  vim.keymap.set(mode, key, cmd, opts)
end

return M
