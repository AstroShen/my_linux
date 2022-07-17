local M = {}

local create_autocmd = vim.api.nvim_create_autocmd

Au_group = {
  cpp = vim.api.nvim_create_augroup("cpp_group", { clear = true }),
  python = vim.api.nvim_create_augroup("python_group", { clear = true }),
  bufCheck = vim.api.nvim_create_augroup("bufCheck", { clear = true }),
  makePrg = vim.api.nvim_create_augroup("makePrg", { clear = true }),
}

local definitions = {
  {
    'BufEnter',
    {
      pattern = "*.cpp",
      command = "setlocal makeprg=g++\\ -std=c++11\\ -g\\ -Wall\\ %:p\\ -o\\ %:p:r",
      group = Au_group.makePrg,
      desc = "make cpp programs"
    }
  },
  {
    'BufEnter',
    {
      pattern = {"*.py", "*.sh", "*.csh", "*.pl", "*.lua"},
      command = "setlocal makeprg=%:p",
      group = Au_group.makePrg,
      desc = "run scripts programs"
    }
  },
  {
    "BufWritePost",
    {
      pattern = "init.lua",
      command = "source <afile> | PackerCompile",
      group = Au_group.bufCheck,
      desc = "Automatically reloads init.lua file when wirte",
    },
  },
  {
    "BufReadPost",
    {
      command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
      group = Au_group.bufCheck,
      desc = "Restore the cursor position when opening a file",
    }
  },
  {
    'QuickFixCmdPost',
    {
      pattern = "[^l]*",
      nested = true,
      command = "cwindow",
      group = Au_group.bufCheck,
      desc = "automatically open quickfix window",
    }
  },
  {
    'QuickFixCmdPost',
    {
      pattern = "l*",
      nested = true,
      command = "lwindow",
      group = Au_group.bufCheck,
      desc = "automatically open quickfix window",
    }
  },
  {
    'BufWritePost',
    {
      pattern = { "*.py", "*.pl", "*.csh", "*.tcsh", "*.sh" },
      callback = function()
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
        if string.match(first_line, "^#!") then
          vim.api.nvim_command("silent !chmod +x <afile>")
        end
      end,
      group = Au_group.bufCheck,
      desc = "add execution rights to script files such as *sh, *.py, etc after :w",
    }
  },
  {
    "Filetype",
    {
      pattern = { "c", "cpp" },
      command = "setlocal tabstop=2 shiftwidth=2",
      group = Au_group.cpp,
    }
  },
  {
    "Filetype",
    {
      pattern = "python",
      command = "setlocal tabstop=4 shiftwidth=4",
      group = Au_group.python,
    }
  },
  {
    'TextYankPost',
    {
      pattern = '*',
      callback = function() vim.highlight.on_yank { timeout = 500 } end,
      group = Au_group.bufCheck,
      desc = "highlight yanks",
    }
  },
  {
    'BufWritePre',
    {
      pattern = '*',
      command = 'call mkdir(expand("<afile>:p:h"), "p")',
      group = Au_group.bufCheck,
      desc = "create non-exist directory when saving files",
    }
  },
  {
    "BufWritePre",
    {
      pattern = "*",
      command = "%s/\\s\\+$//e",
      desc = "strip trailing whitespaces on save",
    }
  }
}

--- Create autocommand groups based on the passed definitions
--- Also creates the augroup automatically if it doesn't exist
---@param definitions table contains a tuple of event, opts, see `:h nvim_create_autocmd`
function M.define_autocmds(definitions)
  for _, entry in ipairs(definitions) do
    local event = entry[1]
    local opts = entry[2]
    if type(opts.group) == "string" and opts.group ~= "" then
      local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
      if not exists then
        vim.api.nvim_create_augroup(opts.group, {})
      end
    end
    vim.api.nvim_create_autocmd(event, opts)
  end
end

M.define_autocmds(definitions)


-- Header template auto filling
File_pattern = {
  cpp = "*.cpp",
  python = "*.py",
}
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
    callback = function()
      vim.api.nvim_buf_set_lines(0, 0, 0, false, Header_template[file_type])
    end,
    group = Au_group[file_type],
  })
end

for key, _ in pairs(Header_template) do
  fill_template(tostring(key))
end


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
