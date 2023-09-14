" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

set termguicolors
colors base16-ashes

let g:crystalline_separators = [
  \ { 'ch': '', 'alt_ch': '', 'dir': '' },
  \ { 'ch': '', 'alt_ch': '', 'dir': '' },
  \ ]

function! g:CrystallineStatuslineFn(winnr)
  let l:curr = a:winnr == winnr()
  let l:s = ''

  if l:curr
    let l:s .= crystalline#ModeSection(0, 'A', 'B')
  else
    let l:s .= crystalline#HiItem('Fill')
  endif
  let l:s .= ' %f '
  if l:curr
    let l:s .= crystalline#Sep(0, 'B', 'Fill')
  endif

  let l:s .= '%='
  if l:curr
    let l:s .= crystalline#Sep(1, 'Fill', 'B')
    let l:s .= crystalline#Sep(1, 'B', 'A')
  endif
  if winwidth(a:winnr) > 80
    let l:s .= ' %l/%L %c%V '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! g:CrystallineTablineFn()
  return crystalline#DefaultTabline({
    \ 'enable_sep': 0,
    \ 'max_tabs': 0,
    \ 'max_width': 1
    \ })
endfunction

function! TabLine()
  return crystalline#bufferline(0, 0, 1)
endfunction

let showtabline=2
let g:crystalline_theme = 'onehalfdark'

set guioptions-=e
set laststatus=2

" ─────────────────────────────────────────────────────────────────────────────
"                                   vim-plug
" ─────────────────────────────────────────────────────────────────────────────

call plug#begin('~/.vim/plugged')

Plug 'rbong/vim-crystalline', { 'tag': '1.0.0' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()
" ─────────────────────────────────────────────────────────────────────────────

set relativenumber
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=1
set colorcolumn=80
set signcolumn=yes

" Folding
set foldlevelstart=99
set foldmethod=manual
" Press Space to fold at the current cursor location.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" Fold the visually selected lines
vnoremap <Space> zf

augroup generic
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix" | q | endif
augroup END

augroup filegroup
  autocmd!
  autocmd FileType cpp setlocal cindent
  autocmd FileType cpp,go inoremap {<CR> {<CR>}<ESC>ko
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType markdown setlocal textwidth=80
augroup END

" Run go vet and golint on golang file save
" let g:go_metalinter_autosave = 1
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave_enabled = ['vet', 'revive']

let mapleader = "-"
let localleader = "\\"

nnoremap <leader>x :noh<cr>
nnoremap <leader>ev :vsplit $HOME/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap jk <ESC>

nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ctrl-Backspace to work like it does in every other app
inoremap <C-h> <C-w>
set backspace=indent,eol,start

" Move selected lines with Alt-j/Alt-k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

filetype plugin indent on
syntax on
