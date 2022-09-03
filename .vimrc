" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

set termguicolors
colors base16-ashes

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill')
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill')
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %l/%L %c%V '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  return crystalline#bufferline(0, 0, 1)
endfunction

let g:crystalline_enable_sep = 0
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let showtabline=2
let g:crystalline_theme = 'jellybeans'

set guioptions-=e
set laststatus=2

" ─────────────────────────────────────────────────────────────────────────────
"                                   vim-plug
" ─────────────────────────────────────────────────────────────────────────────
call plug#begin('~/.vim/plugged')

Plug 'rbong/vim-crystalline'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

call plug#end()
" ─────────────────────────────────────────────────────────────────────────────

set relativenumber
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=2
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
  autocmd FileType py setlocal colorcolumn=80
augroup END

" Run go vet and golint on golang file save
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

let mapleader = "-"

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

