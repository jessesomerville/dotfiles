" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

let g:nerdtree_auto = 1

" Set global bool to enable/disable cloudtop specific configs
let g:cloudtop = 0
if $IS_CLOUDTOP == "true"
    let g:cloudtop = 1
endif

source ~/.vim/config_files/vim_plug.vim
source ~/.vim/config_files/coc.vim
source ~/.vim/config_files/fzf.vim
source ~/.vim/config_files/nerdtree.vim
set runtimepath^=~/.vim/bundle/bbye

if cloudtop
    source ~/.vim/config_files/glug.vim
endif

set relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=2
set colorcolumn=80

hi clear CursorLine
hi CursorLineNR cterm=reverse,bold
hi Error cterm=bold ctermfg=232 ctermbg=10
hi NvimInternalError cterm=bold ctermfg=232 ctermbg=10
hi MatchParen ctermfg=none ctermbg=none cterm=underline
hi ColorColumn ctermbg=236

augroup filegroup
  autocmd!
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
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

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

filetype plugin indent on
syntax on
