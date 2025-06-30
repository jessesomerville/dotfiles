
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'rbong/vim-crystalline', { 'tag': '1.0.0' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'lukas-reineke/virt-column.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()

set relativenumber
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set splitbelow
set splitright
set mouse=a
set cmdheight=1
set signcolumn=yes
set colorcolumn=80
set guioptions-=e
set laststatus=2
set termguicolors
set timeoutlen=200

lua require("virt-column").setup()
hi VirtColumn guifg=#24242f

" Folding
set foldlevelstart=99
set foldmethod=manual
" Press Space to fold at the current cursor location.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" Fold the visually selected lines
vnoremap <Space> zf

autocmd VimLeave * set guicursor=a:ver25

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
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
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

" Run the current file
nnoremap <leader>sh :te %:p<cr>

