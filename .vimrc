" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

" Set global bool to enable/disable cloudtop specific configs TODO(remove)
let g:cloudtop = 0
if $HOME == "/usr/local/google/home/jsomerville"
    let g:cloudtop = 1
endif

source ~/.vim/config_files/vim_plug.vim
source ~/.vim/config_files/theme.vim

if cloudtop
    " Speed up vim when not in piper dir
    let g:piperlib_ignored_dirs = [$HOME]
    source ~/.vim/config_files/glug.vim
endif

set relativenumber
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=2
set colorcolumn=100

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
  " Start NERDTree when Vim starts with a directory argument.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
      \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
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

let g:agriculture#rg_options = '--smart-case --hidden --follow'
nnoremap <leader>f :RgRaw<Space>-g<Space>'*'<Space>
nnoremap <leader>F :Files %:p:h<CR>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

nnoremap <leader>R :%s/ / /g

" Navigate quickfix items
nnoremap <leader>m :cnext<CR>
nnoremap <leader>n :cprevious<CR>

filetype plugin indent on
syntax on
