local create_autocmd = vim.api.nvim_create_autocmd
Au_group = {
  cpp = vim.api.nvim_create_augroup("cpp_group", {clear = true}),
  python = vim.api.nvim_create_augroup("python_group", {clear = true}),
  bufCheck = vim.api.nvim_create_augroup("bufCheck", {clear = true}),
  makePrg = vim.api.nvim_create_augroup("makePrg", {clear = true}),
}
File_pattern = {
  cpp = "*.cpp",
  python = "*.py",
}

-- Automatically reloads init.lua file when wirte
create_autocmd("BufWritePost", {pattern = "init.lua", command = "source <afile> | PackerCompile", group = Au_group.bufCheck, })

-- Restore the cursor position when opening a file
create_autocmd("BufReadPost", {command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]], group = Au_group.bufCheck, })

-- automatically open quickfix window
create_autocmd('QuickFixCmdPost',{pattern="[^l]*", nested = true, command = "cwindow", group = Au_group.bufCheck,} )
create_autocmd('QuickFixCmdPost',{pattern="l*", nested = true, command = "lwindow", group = Au_group.bufCheck,} )

-- add execution rights to script files such as *sh, *.py, etc after :w
local function AddExRight()
  local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
  if string.match(first_line, "^#!") then
    vim.api.nvim_command("silent !chmod +x <afile>")
  end
end
create_autocmd('BufWritePost',{pattern="*", callback = AddExRight, group = Au_group.bufCheck,} )

-- Update date when write buffer
function update_modified_date()
  local l = vim.fn.line("$")
  if l > 10 then
    l = 10
  end
  vim.cmd("exe" .. "'normal mz'")
  vim.cmd("exe" .. " \"1," .. l .. "g/last modified: /s/last modified: .*/Last modified: " .. vim.fn.strftime("%Y %b %d %X") .. " by ShenYuhang\"")
  vim.cmd("exe" .. "'normal `z'")
end
create_autocmd({"BufWritePre", "FileWritePre"}, {pattern = "*", callback = update_modified_date, group = Au_group.bufCheck})

-- Filetype format
create_autocmd("FileType", {pattern = {"c", "cpp"}, command = "setlocal tabstop=2 shiftwidth=2", group = Au_group.cpp, })
create_autocmd("FileType", {pattern = "python", command = "setlocal tabstop=4 shiftwidth=4", group = Au_group.python, })

-- makeprg configuration, this could be constantly changed depending on filetypes and projects
create_autocmd('BufEnter', {pattern="*.cpp", command="setlocal makeprg=g++\\ -std=c++11\\ -g\\ -Wall\\ %:p\\ -o\\ %:p:r", group = Au_group.makePrg} )
-- create_autocmd("BufEnter", {pattern = "*.py", command = "set makeprg=%:p", group = Au_group.makePrg, })
-- create_autocmd("BufEnter", {pattern = "*.sh", command = "set makeprg=%:p", group = Au_group.makePrg, })

-- Header template auto filling
Header_template = {
  cpp = {
    "#include <iostream>",
    "using namespace std;",
  },
  python = {
    "#!/usr/bin/env python",
    "if __name__ == '__main__':",
    "    print('hello python')" -- 4 spaces
  }
}
local function fill_template(file_type)
  create_autocmd("BufNewFile", {
    pattern = File_pattern[file_type],
    callback = function ()
      vim.api.nvim_buf_set_lines(0, 0, 0, false, Header_template[file_type])
    end,
    group = Au_group[file_type],
  })
end
for key, _ in pairs(Header_template) do
  fill_template(tostring(key))
end

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', { pattern  = '*', callback = function() vim.highlight.on_yank{timeout=500} end, group = Au_group.bufCheck})

-- create non-exist directory when saving files
vim.api.nvim_create_autocmd('BufWritePre', { pattern  = '*', command = 'call mkdir(expand("<afile>:p:h"), "p")', group = Au_group.bufCheck})

-- strip trailing whitespaces on save
-- create_autocmd( "BufWritePre", { pattern = "*", command = "%s/\\s\\+$//e", once= true })

-- vim Largefile plugin to disable some burdening feature when opening mega files. This a old vim plugin but plugin manager fails to manage it.
-- So i put the autocmd here since the plugin is very short
vim.cmd([[
" file is large than 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
au!
autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
if exists(':TSBufDisable')
  exec 'TSBufDisable autotag'
  exec 'TSBufDisable highlight'
  exec 'TSBufDisable indent'
  endif
  " no syntax highlighting etc
  set eventignore+=FileType
  " save memory when other file is viewed
  setlocal bufhidden=unload
  " is read-only (write with :w new_filename)
  setlocal buftype=nowrite
  " no undo possible
  setlocal undolevels=-1
  " no swap file
  set noswapfile
  " no plugins
  autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
  endfunction
  ]])

