" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

let g:nerdtree_auto = 0
" Speed up vim when not in piper dir
let g:piperlib_ignored_dirs = [$HOME]

" Set global bool to enable/disable cloudtop specific configs
let g:cloudtop = 0
if $HOME == "/usr/local/google/home/jsomerville"
    let g:cloudtop = 1
endif

source ~/.vim/config_files/vim_plug.vim
source ~/.vim/config_files/coc.vim
source ~/.vim/config_files/ultisnips.vim
"source ~/.vim/config_files/nerdtree.vim
set runtimepath^=~/.vim/bundle/bbye

if cloudtop
    source ~/.vim/config_files/glug.vim
endif

set relativenumber
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=2
set colorcolumn=80

augroup filegroup
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 cindent
  autocmd FileType cpp,go inoremap {<CR> {<CR>}<ESC>ko
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

" Status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'

let mapleader = "-"

" Disable arrow key movement
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
"inoremap <Up> <nop>
"inoremap <Down> <nop>
"inoremap <Left> <nop>
"inoremap <Right> <nop>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>x :noh<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>q :Bdelete<CR>

let g:agriculture#rg_options = '--smart-case --hidden --follow'
nnoremap <leader>f :RgRaw<Space>-g<Space>'*'<Space>
nnoremap <leader>F :Files<CR>

nnoremap <leader>r :%s/ / /g

filetype plugin indent on
syntax on

hi clear Todo " tab highlight color
hi Todo ctermbg=236
hi clear CursorLine
hi CursorLineNR cterm=reverse,bold
hi Error cterm=bold ctermfg=232 ctermbg=10
hi NvimInternalError cterm=bold ctermfg=232 ctermbg=10
hi clear MatchParen
hi MatchParen cterm=bold
hi ColorColumn ctermbg=236
hi CocFloating ctermbg=232
hi SignColumn ctermbg=235
