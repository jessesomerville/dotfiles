call plug#begin('~/.vim/plugged')

" Plug 'vim-syntastic/syntastic'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sheerun/vim-polyglot'
Plug 'cespare/vim-toml'

call plug#end()

inoremap <expr> <Tab>    pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Esc>    pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"

let g:asyncomplete_popup_delay=1000
let g:lsp_diagnostics_enabled=0

nnoremap gd :LspDefinition<CR>
