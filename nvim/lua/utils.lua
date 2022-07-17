local M = {}

-- Check whether a plugin has been loaded, the `packer_plugins` is a global variable defined by packer
function M.is_available(plugin)
  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

-- check whether plugin is available
function M.check_plugin(plugin)
  local available, _ = pcall(require, plugin)
  return available
end

return M
