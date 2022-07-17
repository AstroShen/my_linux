local M = {}
local check_plugin = require("utils").check_plugin

-- nvim-lsp-installer
if check_plugin('nvim-lsp-installer') then
  require('nvim-lsp-installer').settings({
    install_root_dir = vim.fn.stdpath "config" .. "/lsp_servers"
  })
end

-- diagnostic setup
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
})
-- vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {header="", prefix="", focus=false, border="single", scope="line"})]]
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "single" }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "single"
})

-- navigator
if check_plugin("navigator") and check_plugin("cmp_nvim_lsp") then
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local config_dir = vim.fn.stdpath('config')
  require 'navigator'.setup({
    default_mapping = false,
    keymaps = {
      { key = 'gr', func = require('navigator.reference').async_ref, desc = 'async_ref' },
      { mode = 'i', key = '<M-k>', func = vim.lsp.signature_help, desc = 'signature_help' },
      -- { key = '<c-k>', func = vim.lsp.buf.signature_help, desc = 'signature_help' },
      { key = 'g0', func = require('navigator.symbols').document_symbols, desc = 'document_symbols' },
      { key = 'gW', func = require('navigator.workspace').workspace_symbol_live, desc = 'workspace_symbol_live' },
      { key = '<c-]>', func = require('navigator.definition').definition, desc = 'definition' },
      { key = 'gd', func = require('navigator.definition').definition, desc = 'definition' },
      { key = 'gD', func = vim.lsp.buf.declaration, desc = 'declaration' },
      { key = 'gp', func = require('navigator.definition').definition_preview, desc = 'definition_preview' },
      { key = '<Leader>gt', func = require('navigator.treesitter').buf_ts, desc = 'buf_ts' },
      { key = '<Leader>gT', func = require('navigator.treesitter').bufs_ts, desc = 'bufs_ts' },
      { key = '<Leader>ct', func = require('navigator.ctags').ctags, desc = 'ctags' },
      { key = 'K', func = vim.lsp.buf.hover, desc = 'hover' },
      { key = '<Space>ca', mode = 'n', func = require('navigator.codeAction').code_action, desc = 'code_action' },
      {
        key = '<Space>ca',
        mode = 'v',
        func = require('navigator.codeAction').range_code_action,
        desc = 'range_code_action',
      },
      -- { key = '<Leader>re', func = 'rename()' },
      { key = '<Space>rn', func = require('navigator.rename').rename, desc = 'rename' },
      { key = '<Leader>gi', func = vim.lsp.buf.incoming_calls, desc = 'incoming_calls' },
      { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls, desc = 'outgoing_calls' },
      { key = '<Space>D', func = vim.lsp.buf.type_definition, desc = 'type_definition' },
      { key = 'gL', func = require('navigator.diagnostics').show_diagnostics, desc = 'show_diagnostics' },
      { key = 'gG', func = require('navigator.diagnostics').show_buf_diagnostics, desc = 'show_buf_diagnostics' },
      { key = '<Leader>dt', func = require('navigator.diagnostics').toggle_diagnostics, desc = 'toggle_diagnostics' },
      { key = ']d', func = vim.diagnostic.goto_next, desc = 'next diagnostics' },
      { key = '[d', func = vim.diagnostic.goto_prev, desc = 'prev diagnostics' },
      { key = ']O', func = vim.diagnostic.set_loclist, desc = 'diagnostics set loclist' },
      { key = ']r', func = require('navigator.treesitter').goto_next_usage, desc = 'goto_next_usage' },
      { key = '[r', func = require('navigator.treesitter').goto_previous_usage, desc = 'goto_previous_usage' },
      { key = '<C-LeftMouse>', func = vim.lsp.buf.definition, desc = 'definition' },
      { key = 'g<LeftMouse>', func = vim.lsp.buf.implementation, desc = 'implementation' },
      -- { key = '<Leader>k', func = require('navigator.dochighlight').hi_symbol, desc = 'hi_symbol' },
      -- { key = '<Space>wa', func = require('navigator.workspace').add_workspace_folder, desc = 'add_workspace_folder' },
      -- {
      --   key = '<Space>wr',
      --   func = require('navigator.workspace').remove_workspace_folder,
      --   desc = 'remove_workspace_folder',
      -- },
      { key = '<Space>ff', func = vim.lsp.buf.format, mode = 'n', desc = 'format' },
      { key = '<Space>ff', func = vim.lsp.buf.range_formatting, mode = 'v', desc = 'range format' },
      { key = '<Space>rf', func = require('navigator.formatting').range_format, mode = 'n', desc = 'range_fmt_v' },
      { key = '<Space>wl', func = require('navigator.workspace').list_workspace_folders, desc = 'list_workspace_folders' },
      { key = '<Space>la', mode = 'n', func = require('navigator.codelens').run_action, desc = 'run code lens action' },
    },
    on_attach = function(client, bufnr)
      -- lsp related mappings
      -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>gdf", "_f=w<cmd>Telescope lsp_definitions<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>gdv", "_f=b<cmd>Telescope lsp_definitions<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>gdc", "_<cmd>Telescope lsp_definitions<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "gd", "<cmd>Telescope lsp_definitions<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', 'gm', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'v', 'gm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader><leader>l', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader><leader>L', '<cmd>LspStart<cr>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "gr", "<cmd>Trouble lsp_references<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "gT", "<cmd>Trouble workspace_diagnostics<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, "n", "gt", "<cmd>Trouble document_diagnostics<cr>", {noremap = true})
      -- vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>Trouble lsp_implementations<CR>', {noremap = true})

      -- Enable completion triggered by <c-x><c-o>
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
      if vim.api.nvim_buf_get_option(0, "filetype") == "somefile" then
        -- do something specific to the somefile, like autocmd
      end

      -- outside plugins abilities
      require 'illuminate'.on_attach(client)
      require "lsp_signature".on_attach({
        hint_enable = false,
      })
      require('navigator.lspclient.mapping').setup({ bufnr = bufnr, client = client })
    end,
    lsp_installer = true,
    lsp = {
      format_on_save = false,
      format_options = {async = true},
      diagnostic = {
        virtual_text = false,
        severity_sort = true,
      },
      clangd = {
        cmd = { config_dir .. "/lsp_servers/clangd/clangd/bin/clangd", "--background-index", "--header-insertion=never", "--completion-style=detailed", "--header-insertion-decorators=false" },
        flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        rootPatterns = { ".git", "compile_flags.txt", "compile_commands.json" },
        capabilities = capabilities,
      },
      pylsp = {
        cmd = { config_dir .. '/lsp_servers/pylsp/venv/bin/pylsp' },
        flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
        settings = {
          configurationSources = { "flake8" },
          formatCommand = { "black" },
          pylsp = {
            plugins = {
              jedi_completion = {
                include_params = true,
                fuzzy = true,
              },
              jedi_signature_help = { enabled = true },
              pyflakes = { enabled = true },
              -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
              pylsp_mypy = { enabled = false },
              pycodestyle = {
                enabled = true,
                ignore = { 'E501', 'E231', 'E302' },
                maxLineLength = 120,
              },
              yapf = { enabled = true },
            }
          }
        },
        capabilities = capabilities,
      },
      sumneko_lua = {
        cmd = { config_dir .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server" },
        filetypes = { "lua" },
        flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = vim.split(package.path, ";")
            },
            diagnostics = {
              enable = true,
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "describe", "it", "before_each", "after_each", "teardown", "pending" }
            },
            completion = { callSnippet = "Both" },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              maxPreload = 2000,
              preloadFileSize = 40000
            },
            telemetry = { enable = false }
          }
        },
        capabilities = capabilities,
      },
      bashls = {
        cmd = { config_dir .. "/lsp_servers/bash/node_modules/.bin/bash-language-server" }
      }
    }
  })
end

if check_plugin("guihua.maps") then
  require("guihua.maps").setup({
    maps = {
      close_view = '<C-c>',
    }
  })
end

if check_plugin("nvim-autopairs") then
  require('nvim-autopairs').setup {
    disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
  }
end
