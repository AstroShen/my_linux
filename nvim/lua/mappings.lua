local M = {}

-- useful functions for mappings
-- build and run
function M.Run()
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

-- quickly jump to end of line, adding endof char conditionally
function M.goto_end_of_line()
  local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  if vim.o.filetype == 'cpp' or vim.o.filetype == 'c' then
    if string.sub(current_line, -string.len(";")) ~= ";" then
      current_line = current_line .. ";"
      vim.api.nvim_set_current_line(current_line)
    end
  end
  vim.api.nvim_win_set_cursor(0, { line, #current_line })
end

-- search visually selected text
vim.api.nvim_exec(
  [[
function! g:VSetSearch(cmdtype)
let temp = @s
norm! gv"sy
let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
let @s = temp
endfunction

xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]] ,
  false
)

-- default mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local generic_opts_any = { noremap = true, silent = false }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  operator_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_mode = "o",
}

-- builting mappings
--------------------
local builtins = {
  insert_mode = {
    ["<A-j>"] = "<esc>",
    ["<A-e>"] = M.goto_end_of_line,
    ["<A-l>"] = "<right>",
    ["<A-h>"] = "<left>",
    ["<A-k>"] = "<down><C-o>A",
  },
  normal_mode = {
    [";"] = ":",
    ["Y"] = "y$",
    ["vv"] = "^vg_",
    ["<leader>rc"] = ":e $MYVIMRC<cr>",
    ["<leader>w"] = ":update<cr>",
    ["<leader>cd"] = ":cd %:p:h<cr>:pwd<cr>",
    ["<leader>dc"] = ":cd -<cr>",
    ["#"] = "#zz",
    ["*"] = "*zz",
    ["<C-u>"] = "8k",
    ["<C-d>"] = "8j",
    ["<esc><esc>"] = ":noh<cr>",
    ["qw"] = "<c-w>q",
    ["<leader>gi"] = "2g;a",
    ["gV"] = "`[v`]",
    ["p"] = "pgV=<cr>",
    -- windows navigation
    ["<C-h>"] = "<c-w>h",
    ["<C-j>"] = "<c-w>j",
    ["<C-k>"] = "<c-w>k",
    ["<C-l>"] = "<c-w>l",
    ["<C-p>"] = "<c-w>p",
    -- quickfix
    ["<leader>m"] = ":update<cr>:make<cr>",
    ["<leader>cw"] = ":copen 10<cr>",
    ["<leader>cc"] = ":ccl<cr>",
    ["<leader>cn"] = ":cn<cr>",
    ["<leader>cp"] = ":cp<cr>",
  },
  term_mode = {
    ['<esc>'] = [[<C-\><C-n>]],
    ['<A-j>'] = [[<C-\><C-n>]],
    ['<C-h>'] = [[<C-\><C-n><C-W>h]],
    ['<C-j>'] = [[<C-\><C-n><C-W>j]],
    ['<C-k>'] = [[<C-\><C-n><C-W>k]],
    ['<C-l>'] = [[<C-\><C-n><C-W>l]],
  },
  visual_mode = {
    ["<"] = "<gv",
    [">"] = ">gv",

  },
  visual_block_mode = {

  },
  command_mode = {
    ["<C-a>"] = "<HOME>",
    ["<C-e>"] = "<END>",
  },
  operator_mode = {
    ['F']  = ':<C-U>normal! 0f(bviw<cr>',
    ['n('] = ':normal! f(vi(<cr>',
    ['n['] = ':normal! f[vi[<cr>',
    ['n{'] = ':normal! f{vi{<cr>',
    ['n<'] = ':normal! f<vi<<cr>',
    ["n'"] = ":normal! f'vi'<cr>",
    ['n"'] = ':normal! f"vi"<cr>',
  }
}

-- Unsets all keybindings defined in keymaps
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.clear(keymaps)
  local builtins = M.get_builtins()
  for mode, mappings in pairs(keymaps) do
    local translated_mode = mode_adapters[mode] or mode
    for key, _ in pairs(mappings) do
      -- some plugins may override builtins bindings that the user hasn't manually overridden
      if builtins[mode][key] ~= nil or (builtins[translated_mode] ~= nil and builtins[translated_mode][key] ~= nil) then
        pcall(vim.keymap.del, translated_mode, key)
      end
    end
  end
end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

-- Load the builtins keymappings
function M.load_builtins()
  M.load(M.get_builtins())
  M.keys = M.keys or {}
  for idx, _ in pairs(builtins) do
    if not M.keys[idx] then
      M.keys[idx] = {}
    end
  end
end

-- Get the builtins keymappings
function M.get_builtins()
  return builtins
end

M.load_builtins()


return M
