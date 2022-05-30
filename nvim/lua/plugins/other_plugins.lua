require('onedark').setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'italic',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {
      MatchParen = {bg = "gray"},
      TSString = {fg = "#32CD99"},
      String = {fg = "#32CD99" },
      LspSignatureActiveParameter = {fg = "#c678dd"}, -- used by lsp_signature
      QuickFixLine = {bg = "#53565D"}
    }, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('onedark').load()

-- simple configurations of plugins
require("Comment").setup() -- Comment
require'range-highlight'.setup{} -- range-highlight
require'colorizer'.setup() -- colorizer
require('trouble').setup() -- trouble
require("gitsigns").setup{} -- gitsigns

-- barbar
vim.cmd[[
let bufferline = get(g:, 'bufferline', {})
let bufferline.icons = "both"
]]

-- auto-pairs
require('nvim-autopairs').setup{}
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
-- warning: this should not be sourced twice
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

-- indent_blankline
vim.cmd[[
let g:indent_blankline_filetype = ['cpp', 'python', 'verilog', 'perl', 'lua']
]]
require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

-- tmux
require("tmux").setup({
  copy_sync = {
    enable = false,
  },
  navigation = {
    enable_default_keybindings = true,
  },
})

--- nnn
require("nnn").setup({
  command = "nnn -o -H",
  set_default_mappings = 0,
  replace_netrw = 1,
  action = {
    ["<c-t>"] = "tab split",
    ["<c-s>"] = "split",
    ["<c-v>"] = "vsplit",
    ["<c-o>"] = copy_to_clipboard,
  },
})

-- aerial
require("aerial").setup({
  backends = {"lsp", "treesitter", "markdown"},
  close_behavior = "close",
})

-- lualine
local function total_line()
  return tostring(vim.fn.line("$"))
end
local function get_cwd()
  return tostring(vim.fn.getcwd())
end
require'lualine'.setup({
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = { get_cwd, 'filename' },
    lualine_x = {'encoding', 'filesize', 'filetype'},
    lualine_z = {'location', total_line}
  }
})

-- nvim-tree
require'nvim-tree'.setup({
  view = {
    relativenumber = false,
  }
})

-- auto-session
require('auto-session').setup {
  auto_session_root_dir = vim.fn.expand('~') .. '/.tmp/vim_sessions/',
  auto_save_enabled = false,
  auto_restore_enabled = true,
}

-- specs
require('specs').setup{
  show_jumps  = true,
  min_jump = 10,
  popup = {
    delay_ms = 0, -- delay before popup displays
    inc_ms = 25, -- time increments used for fade/resize effects
    blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
    width = 10,
    winhl = "PMenu",
  },
  ignore_filetypes = {},
  ignore_buftypes = {
    nofile = true,
  },
}

-- toggleterm
require('toggleterm').setup{
  open_mapping = [[<c-t>]],
}

-- dial
local augend = require("dial.augend")
require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.octal,
    augend.integer.alias.binary,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool,
    augend.constant.new{ elements = {"and", "or"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"on", "off"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"&&", "||"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"++", "--"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"==", "!="}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"<", ">"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"<<", ">>"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"North", "South", "West", "East"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"left", "right"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"up", "down"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"bottom", "top"}, word = false, cyclic = true, },
    augend.constant.new{ elements = {"dark", "light"}, word = false, cyclic = true, },
  },
}

-- todo-comment
require("todo-comments").setup {
  {
    keywords = {
      TODO = { icon = " ", color = "info", alt = { "todo", "Todo" } },
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    },
    search = {
      pattern = [[\b*(KEYWORDS)\b*:]], -- ripgrep regex
    },
  }
}

-- accelerated-jk
require('accelerated-jk').setup {
  mappings = { j = 'gj', k = 'gk' },
  acceleration_limit = 150,
  acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
  deceleration_table = { { 150, 9999 } },
}

-- which-key
require("which-key").setup{
  window = {border = "single"}
}
