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
" Launch URLs from inside Vim (http://g3doc/company/editors/vim/plugins/corpweb)
Glug corpweb
" Hooks for google-internal virtual file paths
Glug googlepaths
" Applies Google coding style settings to files allow-listed as Google code
Glug googlestyle

" Google specific formatters (go/codefmt-google)
Glug codefmt plugin[mappings] gofmt_executable="goimports"
Glug codefmt-google
augroup autoformat_settings
  autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType markdown AutoFormatBuffer mdformat
  autocmd FileType ncl AutoFormatBuffer nclfmt
  autocmd FileType proto AutoFormatBuffer protofmt
  autocmd FileType textpb AutoFormatBuffer text-proto-format
augroup END

"au User lsp_setup call lsp#register_server({
  "\ 'name': 'CiderLSP',
  "\ 'cmd': {server_info->[
  "\   '/google/bin/releases/cider/ciderlsp/ciderlsp',
  "\   '--tooltag=vim-lsp',
  "\   '--noforward_sync_responses',
  "\ ]},
  "\ 'allowlist': ['proto', 'textproto', 'go', 'bzl', 'gcl', 'borg', 'python', 'sql'],
  "\})

