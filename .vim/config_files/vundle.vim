" set the runtime path to include Vundle and initiatlize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ultisnips lets you write complex patters with a simple trigger
Plugin 'SirVer/ultisnips'
Plugin 'vim-syntastic/syntastic'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'jesseleite/vim-agriculture'
Plugin 'cespare/vim-toml'
Plugin 'prabirshrestha/async.vim'

call vundle#end()
