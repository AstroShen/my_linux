-- my favorite onedark theme
local onedarkpro = require("onedarkpro")
onedarkpro.setup({
  -- colors = {#56b6c2 #98c379 , #c678dd, #e5c07b, #61afef}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
  hlgroups = {
    MatchParen = {bg = "gray"},
    TSString = {fg = "#32CD99"},
    String = {fg = "#32CD99" },
    LspSignatureActiveParameter = {fg = "#c678dd"}, -- used by lsp_signature
    QuickFixLine = {bg = "#53565D"}
  }, -- Override default highlight groups
  styles = {
    strings = "italic", -- Style that is applied to strings
    comments = "italic", -- Style that is applied to comments
    keywords = "NONE", -- Style that is applied to keywords
    functions = "bold", -- Style that is applied to functions
    variables = "NONE", -- Style that is applied to variables
    virtual_text = "NONE", -- Style that is applied to virtual text
  },
  options = {
    cursorline = true, -- Use cursorline highlighting?
    transparency = false, -- Use a transparent background?
    terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
    window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
  }
})
onedarkpro.load()

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
  auto_session_root_dir = '/home/astro/.tmp/vim_sessions/',
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

-- litee
-- configure the litee.nvim library 
require('litee.lib').setup({})
-- configure litee-calltree.nvim
require('litee.calltree').setup({
  on_open = "popout",
})
