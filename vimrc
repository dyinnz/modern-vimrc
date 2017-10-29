"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim and neovim configuration file
" Dyinnz 2017/10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
call plug#begin('~/.vim/plugged')

" Color & Highlight
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'

" UI
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'

" Move
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

" Edit
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'

" Search
Plug 'Shougo/denite.nvim'

" Lint
Plug 'w0rp/ale'

" Cpp
Plug 'vim-scripts/a.vim', { 'for': 'cpp' }
Plug '~/.vim/YouCompleteMe'

" Python
Plug 'klen/python-mode', { 'for': 'python' }

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme
set background=dark " require
colorscheme onedark

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

set synmaxcol=200
set lazyredraw
set scrolloff=3 " Minimum lines to keep above and below cursor

" shell and terminal
set shell=/bin/zsh
" set shell=/home/guoyingzhong/local/bin/zsh
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd TermClose * bd!
set splitbelow
set splitright

" indent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

if has('nvim')
  " nothing
else
  set autoindent
  " UI
  set ttyfast " Speed up
  set showcmd
  set wildmenu
  " Search
  set smartcase
  set incsearch
  set hlsearch
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping
nnoremap <CR> :
tnoremap <Esc> <C-\><C-N>

tnoremap <C-H> <C-\><C-N><C-W>h
tnoremap <C-J> <C-\><C-N><C-W>j
tnoremap <C-K> <C-\><C-N><C-W>k
tnoremap <C-L> <C-\><C-N><C-W>l

tnoremap <C-Q> <C-\><C-N><C-PageUp>
tnoremap <C-E> <C-\><C-N><C-PageDown>
nnoremap <C-Q> <C-PageUp>
nnoremap <C-E> <C-PageDown>

nnoremap <leader>t      : tabnew<CR>
nnoremap <leader>w      : tabclose<CR>
nnoremap <leader>T      : tabe term://.//zsh<CR>
nnoremap <leader>vs     : vs term://.//zsh<CR>
nnoremap <leader>sp     : sp term://.//zsh<CR>

nnoremap <leader>nt     : NERDTreeToggle<CR>
nnoremap <leader>ctags  : !ctags -R && echo "Create tags OK..."<CR>
nnoremap <leader>al     : call AddDashLine()<CR>
nnoremap <leader>ds     : call StripTrailingWhitespace()<CR>

nnoremap <Space>q       : q<CR>
nnoremap <Space>w       : w<CR>
nnoremap <Space>term    : term<CR>
nnoremap <Space>vs      : vs<CR>
nnoremap <Space>sp      : sp<CR>

nnoremap <Space>=       : vertical resize +10<CR>
nnoremap <Space>-       : vertical resize -10<CR>

nnoremap <C-P> : Denite -highlight-matched-char=Identifier file_rec<CR>
nnoremap ff    : Denite -highlight-matched-char=Identifier file_rec<CR>
nnoremap fb    : Denite -highlight-matched-char=Identifier buffer<CR>
nnoremap fg    : Denite -highlight-matched-char=Identifier file_rec/git<CR>
nnoremap fs    : Denite -highlight-matched-char=Identifier -no-empty grep<CR>

vnoremap <Enter> <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function

function AddDashLine()
  call append(line(".")+0, "/*-------------------------------------------------------------------------*/")
endfunction

function StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme='onedark'

" YouCompleteMe
set completeopt-=preview " diable preview window
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf    = 0 " diable confirmation of opening extra_conf file
let g:ycm_show_diagnostics_ui   = 0 " disable

" Python
let g:pymode_python = 'python3'
let g:pymode_lint = 0

" MacOS clang
let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" ale
let g:ale_fixers = {
\   'C++': ['clang'],
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" Denite
call denite#custom#map('insert', '<C-J>',
      \ '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-K>',
      \ '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-D>',
      \ '<denite:scroll_window_downwards>', 'noremap')
call denite#custom#map('insert', '<C-U>',
      \ '<denite:scroll_page_backwards>', 'noremap')

call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files'])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#option('default', 'prompt', '>')
