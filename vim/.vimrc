" ============================ options ===========================
set nocp
filetype plugin indent on

" syntax
set background=dark
colorscheme desert

" base
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set hidden
set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file
set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set scrolloff=3                " keep 3 lines when scrolling
set nu                          "number in edit and relative_number in normal
set relativenumber

" show
set ruler                       " show the current row and column
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis
set splitbelow
set splitright
set fillchars="stl:━,stlnc:━,horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┫,vertright:┣,verthoriz:╋"
set pumheight=14

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present


" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces


" select & complete
set mouse=a
set selection=inclusive
set selectmode=mouse,key
set completeopt = "menu,menuone,noinsert"


" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l


" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange


" ============================ autocommands ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd
" make arrow pointing to the same position as last time modification
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" ============================ key map ============================
let mapleader = "<space>"
inoremap jj <Esc>
inoremap <A-j> <Esc>
nnoremap ; :
nnoremap Y y$
nnoremap v ^vg_
nnoremap <leader>w :update<cr>
nnoremap <leader>rc :e $MYVIMRC<cr>
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>dc :cd -<cr>
nnoremap <C-u> 8k
nnoremap <c-d> 8j
nnoremap <esc><esc> :noh<cr>
nnoremap qw <c-w>q
nnoremap <leader>gi 2g;a
nnoremap gV `[v`]
nnoremap p pgV=<cr>

inoremap <A-e> <C-o>A
inoremap <A-l> <right>
inoremap <A-h> <left>

" 切换窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <c-p> <c-w>p
tnoremap jj <C-\><C-n>
tnoremap <A-j> <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-k> <C-\><C-n><C-W>k
tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-l> <C-\><C-n><C-W>l

" F键
map <F1> :tabnew .<CR> "创建新tab
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TagbarToggle<CR>
map <F4> :set wrap! wrap?<CR>   "是否多行显示过长的行
map <F5> :call CompileRunGcc()<CR>  "编译
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>  "是否显示语法
nnoremap <F7> :g/^\s*$/d<CR>    "去空行
map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=c++ .<CR>

"Keep search pattern at the center of the screen."
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

