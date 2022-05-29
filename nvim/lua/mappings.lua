local M = {}
local utils = require("utils")

-- builting mappings
--------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opt = {noremap = true, silent = true }
local nsopt = {noremap = true, silent = false }

-- mostly used
map("i", "<A-j>", "<esc>", opt)
map("n", ";", ":", nsopt)
map("n", "Y", "y$", opt)
map("n", "vv", "^vg_", opt)
map("n", "<leader>rc", ":e $MYVIMRC<cr>", opt)
map("n", "<leader>w", ":w<cr>", opt)
map("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>", nsopt)
map("n", "<leader>dc", ":cd -<cr>", nsopt)
map("n", "#", "#zz", opt)
map("n", "*", "*zz", opt)
map("c", "<C-a>", "<Home>", nsopt)
map("c", "<C-e>", "<End>", opt)
map("i", "<A-e>", "<C-o>A", opt)
map("i", "<A-l>", "<right>", opt)
map("i", "<A-h>", "<left>", opt)
map("i", "<A-k>", "<esc>A", opt)
map("n", "<C-u>", "8k", opt)
map("n", "<C-d>", "8j", opt)
map("n", "<esc><esc>", ":noh<cr>", opt)
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)
map('n', 'qw', '<c-w>q', opt)
local function toggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end
map('n', '<leader>tt', ':lua toggleTheme()<cr>', opt)
map('n', '<leader>rm', ':!rm -r ~/.tmp/vim_swap/.* ~/.tmp/vim_swap/*<cr>', opt)
map('n', '<leader>gi', '2g;a', opt)
map('n', 'gV', '`[v`]', opt)
map('n', '<leader>sr', ':source $MYVIMRC<cr>', opt)

-- windows motion, note: this is conflict with tmux plugin map settings
-- map("n", "<C-h>", "<C-w>h", opt)
-- map("n", "<C-j>", "<C-w>j", opt)
-- map("n", "<C-k>", "<C-w>k", opt)
-- map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-p>", "<C-w>p", opt)

-- terminal motion mappings
map('t', '<esc>', [[<C-\><C-n>]], opt)
map('t', '<A-j>', [[<C-\><C-n>]], opt)
map('t', '<C-h>', [[<C-\><C-n><C-W>h]], opt)
map('t', '<C-j>', [[<C-\><C-n><C-W>j]], opt)
map('t', '<C-k>', [[<C-\><C-n><C-W>k]], opt)
map('t', '<C-l>', [[<C-\><C-n><C-W>l]], opt)

-- build and run
map('n', '<F5>', ':lua Run()<cr>', opt)
function _G.Run()
  local file_type = vim.o.filetype
  if file_type == 'cpp' then
    -- vim.api.nvim_command("!g++ -std=c++11 -g -Wall %:p -o %:p:r")
    vim.api.nvim_command("!time %:p:r")
  elseif file_type == 'python' then
    vim.api.nvim_command("!time python3 -u %:p")
  elseif file_type == 'lua' then
    vim.api.nvim_command("source %")
  elseif file_type == 'sh' then
    vim.api.nvim_command("!time bash %:p")
  end
end

-- quickfix
map('n', '<leader>m', ':update<cr>:make<cr>', opt)
map("n", "<leader>cw", ":copen 10<cr>", opt)
map("n", "<leader>cc", ":ccl<cr>", opt)
map("n", "<leader>cn", ":cn<cr>", opt)
map("n", "<leader>cp", ":cp<cr>", opt)

-- operator pending mappings
map('o', 'F', ':<C-U>normal! 0f(hviw<cr>', opt) -- Function name
map('o', 'np', ':normal! f(vi(<cr>', opt)
map('o', 'ns', ':normal! f[vi[<cr>', opt)
map('o', 'nc', ':normal! f{vi{<cr>', opt)
map('o', 'na', ':normal! f<vi<<cr>', opt)
map('o', "n'", ":normal! f'vi'<cr>", opt)
map('o', 'n"', ':normal! f"vi"<cr>', opt)

-- plugin mappings
----------------------
--if utils.is_available("nvim-tree.lua") then
  map('n', '<F1>', ':NvimTreeToggle<CR>', opt)
--end
--if utils.is_available("nnn.vim") then
  map('n', '<F2>', ':NnnPicker %:p:h<CR>', opt)
--end
--if utils.is_available("aerial.nvim") then
  map('n', '<F3>', ':AerialToggle!<CR>', opt)
--end
--if utils.is_available("undotree") then
  map('n', '<F4>', ':UndotreeToggle<CR>', opt)
--end
--if utils.is_available("telescope.nvim") then
  map("n", "<leader>fr", "<cmd>Telescope resume<cr>", opt)
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opt)
  map("n", "<leader>fF", ":lua require'telescope.builtin'.find_files({cwd = vim.fn.expand('%:p:h')})<cr>", opt)
  map("n", "<leader>sh", "<cmd>Telescope search_history<cr>", opt)
  map("n", "<leader>b", "<cmd>Telescope buffers<cr>", opt)
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opt)
  map("n", "<leader>ts", "<cmd>Telescope treesitter<cr>", opt)
  map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opt)
  map("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", opt)
  map("n", "<leader>lG", ":lua require'telescope.builtin'.live_grep({grep_open_files = true})<cr>", opt)
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

--end

--if utils.is_available("trouble.nvim") then
  map("n", "gr", "<cmd>Trouble lsp_references<cr>", opt)
  map("n", "gT", "<cmd>Trouble workspace_diagnostics<cr>", opt)
  map("n", "gt", "<cmd>Trouble document_diagnostics<cr>", opt)
  map('n', 'gD', '<cmd>Trouble lsp_implementations<CR>', opt)
--end

--if utils.is_available("barbar.nvim") then
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
--end

--if utils.is_available("specs.nvim") then
  map('n', 'n', 'n:lua require("specs").show_specs()<CR>', opt)
  map('n', 'N', 'N:lua require("specs").show_specs()<CR>', opt)
--end

--if utils.is_available("dial.nvim") then
  map("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
  map("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
  map("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
  map("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
  map("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true})
  map("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true})
--end

--if utils.is_available("auto-session") then
  map("n", "<leader>ss", ':SaveSession<cr>', opt)
  map("n", "<leader>ds", '<Cmd>execute ":DeleteSession "..getcwd()<cr>', opt)
--end

  -- Cheatsheet
  map("n", "<leader><leader>c", ':Cheatsheet<cr>', opt)
  map("n", "<leader><leader>C", ':CheatsheetEdit<cr>', opt)

  -- luasnip
  map({"i", "s"}, "<c-k>", function ()
    if require("luasnip").expand_or_jumpable() then
      require("luasnip").expand_or_jump()
    end
  end, opt)
  map({"i", "s"}, "<c-j>", function ()
    if require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    end
  end, opt)

return M
