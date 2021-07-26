" Use the 'core' Google package (go/vim/packages).
source /usr/share/vim/google/core.vim

" Google filetype settings
Glug languages

" Load blaze integration (go/blazevim).
Glug blaze plugin[mappings]

" Update BUILD files for golang code (go/blazedeps)
Glug blazedeps auto_filetypes=`['go']`

" Fetch critique comments (:h critique)
Glug critique plugin[mappings]

" Hooks for google-internal virtual file paths
Glug googlepaths

" Applies Google coding style settings to files whitelisted as Google code
Glug googlestyle

" Outline window similar to vscode (go/vim/plugins/outline-window)
Glug outline-window

" Navigate between related files (go/vim/plugins/relatedfiles)
Glug relatedfiles plugin[mappings]

" Google specific snippets (go/ultisnips)
Glug ultisnips-google

" Google specific formatters (go/codefmt-google)
Glug codefmt plugin[mappings] gofmt_executable="goimports"
Glug codefmt-google
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,javascript,typescript AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType proto AutoFormatBuffer protofmt
  autocmd FileType python AutoFormatBuffer pyformat
  autocmd FileType textpb AutoFormatBuffer text-proto-format
augroup END
