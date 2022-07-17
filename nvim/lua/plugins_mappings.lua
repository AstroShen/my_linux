local map = vim.keymap.set
local opt = { noremap = true, silent = true }

local available, _ = pcall(require, "nvim-tree")
if not available then
  print "nvim-tree not available"
else
  map('n', '<F1>', ':NvimTreeToggle<CR>', opt)
  map('n', '<F4>', ':UndotreeToggle<CR>', opt)
end

available, _ = pcall(require, "nnn")
if not available then
  print "nnn not available"
else
  map('n', '<F2>', ':NnnPicker %:p:h<CR>', opt)
end

available, _ = pcall(require, "aerial")
if not available then
  print "aerial not available"
else
  map('n', '<F3>', ':AerialToggle!<CR>', opt)
end

available, _ = pcall(require, "telescope")
if not available then
  print "telescope not available"
else
  map("n", "<leader>fr", "<cmd>Telescope resume<cr>", opt)
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opt)
  map("n", "<leader>fF", ":lua require'telescope.builtin'.find_files({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
  map("n", "<leader>sh", "<cmd>Telescope search_history<cr>", opt)
  map("n", "<leader>b", "<cmd>Telescope buffers<cr>", opt)
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opt)
  map("n", "<leader>ts", "<cmd>Telescope treesitter<cr>", opt)
  map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opt)
  map("n", "<leader>lG", ":lua require'telescope.builtin'.live_grep({grep_open_files = true})<cr>", opt)
  map("n", "<leader>lg", ":lua require'telescope.builtin'.live_grep({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
  map("n", "<leader>gp", "<cmd>Telescope grep_string<cr>", opt)
  map("n", "<leader>ch", "<cmd>Telescope command_history<cr>", opt)
  map("n", "<leader>k", "<cmd>Telescope keymaps<cr>", opt)
  map("n", "<leader>ht", "<cmd>Telescope help_tags<cr>", opt)
  map("n", "<leader>hl", "<cmd>Telescope highlights<cr>", opt)
  map("n", "<leader>j", "<cmd>Telescope jumplist<cr>", opt)
  map("n", "<leader>gf", ":lua require'telescope.builtin'.git_files({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
  map("n", "<leader>gc", ":lua require'telescope.builtin'.git_commits({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
  map("n", "<leader>gs", ":lua require'telescope.builtin'.git_status({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
  map("n", "<leader>gb", ":lua require'telescope.builtin'.git_branches({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
end

available, _ = pcall(require, "bufferline")
if not available then
  print "barbar not available"
else
  map("n", "<S-TAB>", ":BufferPrevious<CR>", opt)
  map("n", "<TAB>", ":BufferNext<CR>", opt)
  map("n", "<leader>q", ":BufferClose<CR>", opt)
  map("n", "<leader>Q", ":BufferCloseAllButCurrent<CR>", opt)
  map("n", "<leader>1", ":BufferGoto 1<CR>", opt)
  map("n", "<leader>2", ":BufferGoto 2<CR>", opt)
  map("n", "<leader>3", ":BufferGoto 3<CR>", opt)
  map("n", "<leader>4", ":BufferGoto 4<CR>", opt)
  map("n", "<leader>5", ":BufferGoto 5<CR>", opt)
  map("n", "<leader>6", ":BufferGoto 6<CR>", opt)
  map("n", "<leader>7", ":BufferGoto 7<CR>", opt)
  map("n", "<leader>8", ":BufferGoto 8<CR>", opt)
  map("n", "<leader>9", ":BufferGoto 9<CR>", opt)
  map("n", "<leader>0", ":BufferGoto 10<CR>", opt)
end

available, _ = pcall(require, "specs")
if not available then
  print "specs not available"
else
  map('n', 'n', 'n:lua require("specs").show_specs()<CR>', opt)
  map('n', 'N', 'N:lua require("specs").show_specs()<CR>', opt)
end

available, _ = pcall(require, "dial.map")
if not available then
  print "dial not available"
else
  map("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
  map("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
  map("v", "<c-a>", require("dial.map").inc_visual(), { noremap = true })
  map("v", "<c-x>", require("dial.map").dec_visual(), { noremap = true })
  map("v", "g<c-a>", require("dial.map").inc_gvisual(), { noremap = true })
  map("v", "g<c-x>", require("dial.map").dec_gvisual(), { noremap = true })
end

available, _ = pcall(require, "auto-session")
if not available then
  print "auto-session not available"
else
  map("n", "<leader>ss", ':SaveSession<cr>', opt)
  map("n", "<leader>ds", ':DeleteSession<cr>', opt)
end

available, _ = pcall(require, "cheatsheet")
if not available then
  print "cheatsheet not available"
else
  map("n", "<leader><leader>c", ':Cheatsheet<cr>', opt)
  map("n", "<leader><leader>C", ':CheatsheetEdit<cr>', opt)
end

available, _ = pcall(require, "luasnip")
if not available then
  print "luasnip not available"
else
  map({ "i", "s" }, "<c-k>", function()
    if require("luasnip").expand_or_jumpable() then
      require("luasnip").expand_or_jump()
    end
  end, opt)
  map({ "i", "s" }, "<c-j>", function()
    if require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    end
  end, opt)
end
