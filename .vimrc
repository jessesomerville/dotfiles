" Enable modern Vim features not compatible with Vi spec.
set nocompatible
filetype off

" Speed up vim when not in piper dir
let g:piperlib_ignored_dirs = [$HOME]

" Set global bool to enable/disable cloudtop specific configs TODO(remove)
let g:cloudtop = 0
if $HOME == "/usr/local/google/home/jsomerville"
    let g:cloudtop = 1
endif

source ~/.vim/config_files/vim_plug.vim
"source ~/.vim/config_files/coc.vim
"source ~/.vim/config_files/ultisnips.vim
source ~/.vim/config_files/theme.vim

if cloudtop
    source ~/.vim/config_files/glug.vim
endif

"if exists('$TMUX')
  "let g:fzf_layout = { 'tmux': '-p90%,60%' }
"else
  "let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"endif

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
" If the current line is not a fold, the default behavior for Space is used.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" Fold the visually selected lines
vnoremap <Space> zf
" Save folds when closing a file
"augroup remember_folds
  "autocmd!
  "autocmd BufWinLeave * mkview
  "autocmd BufWinEnter * silent! loadview
"augroup END

augroup filegroup
  autocmd!
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 cindent
  autocmd FileType cpp,go inoremap {<CR> {<CR>}<ESC>ko
  autocmd FileType go setlocal tabstop=2 shiftwidth=2
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType py setlocal colorcolumn=80
  autocmd FileType zsh setlocal tabstop=2 shiftwidth=2
augroup END

" General autocommands
augroup generic
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix" | q | endif
  " Start NERDTree when Vim starts with a directory argument.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
      \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
augroup END

" Run go vet and golint on golang file save
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

" Status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'

let mapleader = "-"

" Disable arrow key movement in normal mode
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>x :noh<cr>
nnoremap <leader>ev :vsplit $HOME/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>q :Bdelete<CR>

let g:agriculture#rg_options = '--smart-case --hidden --follow'
nnoremap <leader>f :RgRaw<Space>-g<Space>'*'<Space>
nnoremap <leader>F :Files %:p:h<CR>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

nnoremap <leader>R :%s/ / /g

" Navigate quickfix items
nnoremap <leader>m :cnext<CR>
nnoremap <leader>n :cprevious<CR>

inoremap jk <Esc>

filetype plugin indent on
syntax on

set tgc  " Enable 24-bit colors



hi clear Todo " tab highlight color
hi clear CursorLine
hi CursorLineNR cterm=reverse,bold
hi Error cterm=bold ctermfg=232 ctermbg=10
hi NvimInternalError cterm=bold ctermfg=232 ctermbg=10
hi clear MatchParen
hi MatchParen cterm=bold
hi ColorColumn guibg='#282828'
hi SignColumn guibg='#032029'
hi clear Pmenu
hi Pmenu ctermbg=0 ctermfg=4 guibg=#2d2e30
hi PmenuSel guibg=#3a3b3d
hi Folded guibg='#2d2e30' guifg='#7a7b7d'
hi clear VertSplit
hi VertSplit guifg='#282828'
hi clear EndOfBuffer
hi EndOfBuffer guifg='#1a1b1d'
hi Constant guifg='#92B55F'
hi clear Visual
hi Visual guibg='#3a3b3d'
hi Comment  guibg=bg  guifg=#8f8e8d  gui=none    ctermbg=8   ctermfg=7
hi clear Error

if cloudtop
  hi Pmenu ctermfg=6
endif
