set nocompatible
set autoread            " auto update the file
set backspace=2         " allow backspacing over everything in insert mode
set clipboard=unnamed   " Use Mac OS X clipboard
set encoding=utf-8
set foldnestmax=2    " Limit nesting number of folds
set history=50          " keep 50 lines of command line history
set hlsearch            " Highlight search
set ignorecase          " Ignore case in search
set incsearch           " Show incremental searching
set laststatus=2        " Always show status bar (for vim-airline)
set noshowmode          " Hide the mode, vim-airline displays it
set number              " Show current absolute line number
set relativenumber      " Show line numbers relative to current cursor pos
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set smartcase           " If you search a capital letter, be case sensitive
set splitbelow          " Open horizontal splits below
set splitright          " Open vertical splits on right
set ttimeoutlen=50      " Timeout length for commands
set scrolloff=5

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Valloric/MatchTagAlways'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'

Plug 'vim-scripts/camelcasemotion'
Plug 'moll/vim-bbye'

Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'starcraftman/vim-eclim', { 'for': 'java' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'keith/swift.vim'

call plug#end()

" ts = tab stop for using <TAB> key
" sw = shift width for << and >>
" sts = soft tab stop for spaces using <TAB> key
" et = expand <TAB> into spaces
syntax on

set t_Co=256
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = []

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

set ts=2 sw=2 sts=2 et

filetype plugin indent on
autocmd FileType ruby setlocal ts=2 sw=2 sts=2 et
autocmd FileType python setlocal ts=4 sw=4 sts=4 et
autocmd FileType html setlocal ts=4 sw=4 sts=4 et
autocmd FileType htmldjango setlocal ts=4 sw=4 sts=4 et
autocmd FileType javascript setlocal ts=2 sw=2 sts=2 et
autocmd FileType css setlocal ts=4 sw=4 sts=4 et
autocmd FileType mkd setlocal ts=4 sw=4 sts=0 noet
" Folding stuff
set foldmethod=indent
set foldnestmax=1
nnoremap <Space> za
vnoremap <Space> zf
"set nofoldenable

" Always show the status line!
set laststatus=2

" Extra commands
let mapleader = ","
map <Leader>N :bp<CR> " Previous buffer
map <Leader>n :bn<CR> " Next buffer
map <Leader>h <C-w>h<CR> " Pane navigation
map <Leader>j <C-w>j<CR> " Pane navigation
map <Leader>l <C-w>l<CR> " Pane navigation
map <Leader>k <C-w>k<CR> " Pane navigation
map <Leader>f :PyLintAuto<cr>
set pastetoggle=<leader>p
command! Q q " bind :Q to :q
command! Qall qall

" Show different tabstop and EOL characters
set listchars=tab:▸\ ,eol:¬
map <silent> <Leader>I :set list!<CR>

" Speed up redraw and stuff
set lazyredraw
set ttyfast

let g:vim_markdown_folding_disabled=1

highlight VertSplit ctermbg=bg
highlight VertSplit ctermfg=12
highlight NonText ctermfg=bg
highlight clear SignColumn

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

autocmd StdinReadPre * let s:std_in=1

function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction

autocmd VimEnter * call StartUp()

let g:NERDTreeWinSize=45

noremap <silent> <c-c> :noh<cr><c-c>
nnoremap <Leader>q :Bdelete<CR>

let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night_Bright',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ], [ 'filename']  ],
      \   'right': [ [ 'lineinfo'  ], ['percent'],[ 'filetype'  ]  ]
      \
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'mode': 'LightLineMode',
      \
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineMode()
	let fname = expand('%:t')
	return fname =~ 'NERD_tree' ? 'NERDTree' :
	      \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
