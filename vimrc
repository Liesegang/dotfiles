" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif


" ================ General Config ====================

set history=1000                "Store lots of :cmdline history

set visualbell                  "No sounds

set clipboard=unnamed,unnamedplus
                                "Use OS-clipbord without egister

set mouse=a                     "Allow mouse

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","



" ================ Display Config ====================

set number                      "Line numbers
set cursorline                  "Change bg color of current row
set cursorcolumn                "Change bg color of current column

set list                        "Show invisible chars
set listchars=tab:▸\ ,trail:·,eol:↲,extends:❯,precedes:❮
                                "Set symbol of invisible chars

set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set laststatus=2                "Show status bar tsuneni
set cmdheight=2                 "Show 2-line message bar 
set matchpairs& matchpairs+=<:> " 対応括弧に<と>のペアを追加
set showmatch                   " Emphasize brackets
set matchtime=1                 " 括弧の対応表示時間[1/10秒]
set helpheight=999              "Full-screen help window
set display=uhex                " 表示できない文字を16進数で表示

set gcr=a:blinkon0              "Disable cursor blink

syntax on                       "Turn on syntax highlighting
set background=dark             "Use dark theme



" ================ Cursor Config ====================

set backspace=indent,eol,start  "Allow backspace in insert mode



" " ================ Scrolling ========================

set scrolloff=8                 "Keep lines vertically
set sidescrolloff=16            "Keep chars hrizontally
set sidescroll=1                "Scroll by 1 chars horizontally



" ================ Loading Saving Config ===================

set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden                      "Allow open another file before saving

set noswapfile
set nobackup
set nowb

set confirm                     "Confirm unsaved file before close



" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif



" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

set linebreak    "Wrap lines at convenient points
set breakindent  "Indent wapped text



" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set wrapscan        " Back to front on search
set gdefault        " Use g option as default on replacement



" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default



" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif



" ================ Control setting ===============

" 表示行単位で上下移動するように
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" 逆に普通の行単位で移動したい時のために逆の map も設定しておく
nnoremap gj j
nnoremap gk k

" ================ dein.vim ========================

" directory for plugins
let s:dein_dir = expand('~/.vim/dein')
" directory for dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" download dein.vim if it is not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" bagin config
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Toml dir which contains plugins list
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " Cache toml files
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " end config
  call dein#end()
  call dein#save_state()
endif

" Install if uninstalled plugin exists
if dein#check_install()
  call dein#install()
endif



" ================ Custom Settings ========================

so ~/.vim/settings.vim
