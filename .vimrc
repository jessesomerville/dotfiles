" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

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
set runtimepath^=~/.vim/bundle/bbye

if cloudtop
    source ~/.vim/config_files/glug.vim
endif

set relativenumber
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=2
set colorcolumn=80

" Folding
set foldlevelstart=99
set foldmethod=manual
" Press Space to fold at the current cursor location.
" If the current line is not a fold, the default behavior for Space is used.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" Fold a the visually selected lines
vnoremap <Space> zf
" Save folds when closing a file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

augroup filegroup
  autocmd!
  autocmd FileType zsh setlocal tabstop=2 shiftwidth=2
  autocmd FileType go setlocal tabstop=2 shiftwidth=2
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 cindent
  autocmd FileType cpp,go inoremap {<CR> {<CR>}<ESC>ko
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

" General autocommands
augroup generic
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix" | q | endif
augroup END

" Run go vet and golint on golang file save
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

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

nnoremap <leader>R :%s/ / /g

" Navigate quickfix items
nnoremap <leader>m :cnext<CR>
nnoremap <leader>n :cprevious<CR>

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
hi SignColumn ctermbg=235
hi clear Pmenu
hi Pmenu ctermbg=0 ctermfg=4
hi Folded ctermbg=236

if cloudtop
  hi Pmenu ctermfg=6
endif
