vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true -- 搜索高亮
vim.opt.incsearch = true
vim.opt.showmode = false -- 使用增强状态栏后不再需要 vim 的模式提示
vim.opt.cmdheight = 1 -- 命令行高为2，提供足够的显示空间
vim.opt.autoread = true -- 当文件被外部程序修改时，自动加载
vim.opt.wrap = false -- 禁止折行
vim.opt.hidden = true -- 允许隐藏被修改过的buffer
vim.opt.mouse = "a" -- 鼠标支持
vim.opt.backup = false -- 禁止创建备份文件
vim.opt.writebackup = false
vim.opt.updatetime = 300 -- smaller updatetime
vim.opt.timeoutlen = 500 -- 等待mappings
vim.opt.splitbelow = true -- split window 从下边和右边出现
vim.opt.splitright = true
vim.opt.completeopt = "menu,menuone,noinsert" -- 自动补全不自动选中
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.pumheight = 14 --浮动窗口高度
vim.opt.fillchars = {stl = '━', stlnc = '━', horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', }
vim.opt.matchpairs:append({"<:>"})
-- enable undo and swap 
vim.cmd([[
if has("persistent_undo")
  let undo_target_path = expand('~/.tmp/vim_undo')
  let swap_target_path = expand('~/.tmp/vim_swap')
  if !isdirectory(undo_target_path)
    call mkdir(undo_target_path, "p", 0700)
    endif
    if !isdirectory(swap_target_path)
      call mkdir(swap_target_path, "p", 0700)
      endif
      let &undodir=undo_target_path
      set undofile
      let &dir=swap_target_path
      endif
      ]])
vim.opt.guifont = "Hack NF:h15"
