local M = {}
local utils = require("utils")

-- check everymodule is loadable
local modules = {
  "nvim-lsp-installer",
  "lspconfig",
  "illuminate",
  "lsp_signature"
}
-- utils.check_module(modules)

-- nvim-lsp-installer
require('nvim-lsp-installer').settings({
  install_root_dir = vim.fn.stdpath "config".."/lsp_servers"
})

-- lspconfig
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_on_attach = function(client, bufnr)
  -- lsp related mappings
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>gdf", "_f=w<cmd>Telescope lsp_definitions<cr>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>gdv", "_f=b<cmd>Telescope lsp_definitions<cr>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>gdc", "_<cmd>Telescope lsp_definitions<cr>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "gd", "<cmd>Telescope lsp_definitions<cr>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gm', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'v', 'gm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader><leader>l', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader><leader>L', '<cmd>LspStart<cr>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {noremap = true})

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  if vim.api.nvim_buf_get_option(0, "filetype") == "somefile" then
    -- do something specific to the somefile, like autocmd
  end

  -- outside plugins abilities
  require 'illuminate'.on_attach(client)
  require "lsp_signature".on_attach({
    hint_enable = false,
  })
end
local lsp_servers = {"clangd", "pylsp", "sumneko_lua", "bashls"}
local config_dir = vim.fn.stdpath('config')
for _, server in ipairs(lsp_servers) do
  local cmd
  local rootPatterns
  local flags
  local settings
  if server == 'clangd' then
    if jit.os == "Linux" then
      cmd = { config_dir .. "/lsp_servers/clangd/clangd/bin/clangd", "--background-index", "--cross-file-rename", "--header-insertion=never", "--completion-style=detailed", "--header-insertion-decorators=false" }
    elseif jit.os == "Windows" then
      cmd = { config_dir .. "\\lsp_servers\\clangd\\clangd\\bin\\clangd.exe", "--background-index", "--cross-file-rename", "--header-insertion=never", "--completion-style=detailed", "--header-insertion-decorators=false" }
    end
    rootPatterns = { ".git", "compile_flags.txt", "compile_commands.json" }
  elseif server == 'pylsp' then
    if jit.os == "Linux" then
      cmd = {config_dir .. '/lsp_servers/pylsp/venv/bin/pylsp'}
    elseif jit.os == "Windows" then
      cmd = {config_dir .. '\\lsp_servers\\pylsp\\venv\\Scripts\\pylsp.exe'}
    end
    flags = { debounce_text_changes = 150, }
    settings = {
      configurationSources = {"flake8"},
      formatCommand = {"black"},
      pylsp = {
        plugins = {
          jedi_completion = {
            include_params = true,
            fuzzy = true,
          },
          jedi_signature_help = {enabled = true},
          pyflakes={enabled=true},
          -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
          pylsp_mypy={enabled=false},
          pycodestyle={
            enabled=true,
            ignore={'E501', 'E231', 'E302'},
            maxLineLength=120,
          },
          yapf = {enabled = true},
        }
      }
    }
  elseif server == 'sumneko_lua' then
    if jit.os == "Linux" then
      cmd = {config_dir .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"}
    elseif jit.os == "Windows" then
      cmd = {config_dir .. "\\lsp_servers\\sumneko_lua\\extension\\server\\bin\\lua-language-server.exe"}
    end
  elseif server == 'bashls' then
    cmd = {config_dir .. "/lsp_servers/bash/node_modules/.bin/bash-language-server"}
  end
  lspconfig[server].setup {
    cmd = cmd,
    rootPatterns = rootPatterns,
    flags = flags,
    settings = settings,
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  }
end
-- diagnostic setup
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
})
vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {header="", prefix="", focus=false, border="single", scope="line"})]]
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
vim.lsp.handlers.hover, {border = "single"}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
vim.lsp.handlers.signature_help, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "single"
})
