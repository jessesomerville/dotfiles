" Use the 'google' package by default (see http://go/vim/packages).
source /usr/share/vim/google/google.vim

" Plugin configuration.
" See http://google3/devtools/editors/vim/examples/ for example configurations

" The default mapping is \= (or <leader>= if g:mapleader has a custom value),
" with
" - \== formatting the current line or selected lines in visual mode
"   (:FormatLines).
" - \=b formatting the full buffer (:FormatCode).
"
" To bind :FormatLines to the same key in insert and normal mode, add:
"   noremap <C-K> :FormatLines<CR>
"   inoremap <C-K> <C-O>:FormatLines<CR>
Glug codefmt plugin[mappings] gofmt_executable="goimports"
Glug codefmt-google

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,javascript,typescript AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType textpb AutoFormatBuffer text-proto-format
  autocmd FileType proto AutoFormatBuffer protofmt
augroup END

"Glug youcompleteme-google
"let g:ycm_filetype_blacklist = {'cpp': 1, 'c': 1}

" Load the automated blaze dependency integration for Go.
" Note: for Go, blazedeps uses the Go team's glaze tool, which is fully
" supported by the Go team. The plugin is currently unsupported for other
" languages.
Glug blazedeps auto_filetypes=`['go']`

" Load piper integration (http://go/VimPerforce).
Glug piper plugin[mappings]

" Load Critique integration. Use :h critique for more details.
Glug critique plugin[mappings]

" Load blaze integration (http://go/blazevim).
Glug blaze plugin[mappings]

" Load the syntastic plugin (http://go/vim/plugins/syntastic-google).
" Note: this requires installing the upstream syntastic plugin from
" https://github.com/vim-syntastic/syntastic.
Glug syntastic-google

" Load the ultisnips plugin (http://go/ultisnips).
" Note: this requires installing the upstream ultisnips plugin from
" https://github.com/SirVer/ultisnips.
Glug ultisnips-google

Glug corpweb plugin[mappings]
