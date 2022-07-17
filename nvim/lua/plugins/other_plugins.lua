local check_plugin = require("utils").check_plugin

-- onedark
if check_plugin("onedark") then
  require('onedark').setup {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

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
      -- MatchParen = {bg = "gray"},
      TSString = { fg = "#32CD99" },
      String = { fg = "#32CD99" },
      LspSignatureActiveParameter = { fg = "#c678dd" }, -- used by lsp_signature
      QuickFixLine = { bg = "#53565D" },
      -- plugin nagivator list item
      GHTextViewDark = { fg = "#c678dd", bg = "#332e55" },
      GHListDark = { fg = "#c678dd", bg = "#103234" },
      GHListHl = { fg = "#c678dd", bg = "#404254" },
    }, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true, -- use undercurl instead of underline for diagnostics
      background = true, -- use background color for virtual text
    },
  }
  require('onedark').load()
end

-- simple configurations of plugins
if check_plugin("Comment") then
  require("Comment").setup() -- Comment
end
if check_plugin("range-highlight") then
  require 'range-highlight'.setup {} -- range-highlight
end
if check_plugin("colorizer") then
  require 'colorizer'.setup() -- colorizer
end
if check_plugin("trouble") then
  require('trouble').setup() -- trouble
end
if check_plugin("gitsigns") then
  require("gitsigns").setup {} -- gitsigns
end
if check_plugin("project_nvim") then
  require('project_nvim').setup {} -- project
end
if check_plugin("telescope") then
  require('telescope').load_extension('projects')
end
if check_plugin("notify") then
  vim.notify = require("notify")
end

-- barbar
if check_plugin("bufferline") then
  vim.cmd [[
  let bufferline = get(g:, 'bufferline', {})
  let bufferline.icons = "both"
  ]]
end

-- auto-pairs
if check_plugin("nvim-autopairs") then
  require('nvim-autopairs').setup {}
  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  -- warning: this should not be sourced twice
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

-- indent_blankline
if check_plugin("indent_blankline") then
  vim.cmd [[
  let g:indent_blankline_filetype = ['cpp', 'python', 'verilog', 'perl', 'lua']
  ]]
  require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  }
end

-- tmux
if check_plugin("tmux") then
  require("tmux").setup({
    copy_sync = {
      enable = true,
    },
    navigation = {
      enable_default_keybindings = true,
    },
  })
end

--- nnn
if check_plugin("nnn") then
  require("nnn").setup({
    command = "nnn -o -H",
    set_default_mappings = 0,
    replace_netrw = 1,
    action = {
      ["<c-t>"] = "tab split",
      ["<c-s>"] = "split",
      ["<c-v>"] = "vsplit",
    },
  })
end

-- aerial
if check_plugin("aerial") then
  require("aerial").setup({
    backends = { "lsp", "treesitter", "markdown" },
    close_behavior = "close",
  })
end

-- lualine
if check_plugin("lualine") then
  local function total_line()
    return tostring(vim.fn.line("$"))
  end

  local function get_cwd()
    return tostring(vim.fn.getcwd())
  end

  require 'lualine'.setup({
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { get_cwd, 'filename' },
      lualine_x = { 'encoding', 'filesize', 'filetype' },
      lualine_z = { 'location', total_line }
    }
  })
end

-- nvim-tree
if check_plugin("nvim-tree") then
  require 'nvim-tree'.setup({
    view = {
      relativenumber = false,
    }
  })
end

-- auto-session
if check_plugin("auto-session") then
  require('auto-session').setup {
    auto_session_root_dir = vim.fn.expand('~') .. '/.tmp/vim_sessions/',
    auto_save_enabled = false,
    auto_restore_enabled = true,
  }
end

-- specs
if check_plugin("specs") then
  require('specs').setup {
    show_jumps       = true,
    min_jump         = 10,
    popup            = {
      delay_ms = 0, -- delay before popup displays
      inc_ms = 25, -- time increments used for fade/resize effects
      blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 10,
      winhl = "PMenu",
    },
    ignore_filetypes = {},
    ignore_buftypes  = {
      nofile = true,
    },
  }
end

-- toggleterm
if check_plugin("toggleterm") then
  require('toggleterm').setup {
    open_mapping = [[<c-t>]],
  }
end

-- dial
if check_plugin("dial.augend") then
  local augend = require("dial.augend")
  require("dial.config").augends:register_group {
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.octal,
      augend.integer.alias.binary,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.constant.alias.bool,
      augend.constant.new { elements = { "and", "or" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "on", "off" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "&&", "||" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "++", "--" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "==", "!=" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "<", ">" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "<<", ">>" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "North", "South", "West", "East" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "left", "right" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "up", "down" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "bottom", "top" }, word = false, cyclic = true, },
      augend.constant.new { elements = { "dark", "light" }, word = false, cyclic = true, },
    },
  }
end

-- todo-comment
if check_plugin("todo-comments") then
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
end

-- accelerated-jk
if check_plugin("accelerated-jk") then
  require('accelerated-jk').setup {
    mappings = { j = 'gj', k = 'gk' },
    acceleration_limit = 150,
    acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
    deceleration_table = { { 150, 9999 } },
  }
end

-- which-key
if check_plugin("which-key") then
  require("which-key").setup {
    window = { border = "single" }
  }
end
