local check_plugin = require("utils").check_plugin

-- luasnip
if check_plugin("snippets") then
  require("snippets")
end

-- nvim-cmp
if check_plugin("cmp") and check_plugin("lspkind") then
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local cmp = require 'cmp'
  local compare = require 'cmp.config.compare'
  local lspkind = require('lspkind')
  local source_mapping = {
    buffer = "[buf]",
    luasnip = "[ls]",
    nvim_lsp = "[lsp]",
    nvim_lua = "[lua]",
    path = "[path]",
  }
  cmp.setup({
    completion = {
      keyword_length = 2,
    },
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
          local menu = source_mapping[entry.source.name]
          vim_item.menu = menu
          return vim_item
        end
      })
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-y>"] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = function(fallback)
        if cmp.visible() then
          if cmp.get_active_entry() == nil then
            cmp.close()
          else
            cmp.confirm({ select = true })
          end
        else
          fallback() -- If you are using vim-endwise, this fallback function will be behaive as the vim-endwise.
        end
      end,
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp', priority = 8 },
      { name = 'luasnip', priority = 7 },
      { name = 'nvim_lua', priority = 7 },
      { name = 'path', priority = 7 },
      { name = 'buffer', keyword_length = 3 },
      { name = 'calc' },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.locality,
        compare.recently_used,
        compare.exact,
        compare.score,
        compare.offset,
        compare.order,
      },
    },
    experimental = {
      ghost_text = true,
    }
  })
end
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     {--[[  name = 'cmdline', keyword_pattern=[=[[^[:blank:]\!]*]=] ]]}
--   })
-- })
