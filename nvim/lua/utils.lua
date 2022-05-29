local M = {}

-- Check whether a plugin has been loaded, the `packer_plugins` is a global variable defined by packer
function M.is_available(plugin)
  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

-- check everymodule is loadable
function M.check_module(modules)
  for _, source in ipairs(modules) do
    local status_ok, fault = pcall(require, source)
    if not status_ok then
      error("Failed to load " .. source .. "\n\n" .. fault)
    end
  end
end

return M
