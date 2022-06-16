set termguicolors
colors deus

" Status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='base16_classic'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' L:'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = ' C:'

" Uncomment to have statusline be pointy.
"let g:airline_powerline_fonts = 1
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''

hi Normal guibg='#191c21'
hi Visual guibg='#3a3b3d'
hi EndOfBuffer guifg='#191c21'
hi ColorColumn guibg='#38393a' guifg='#38393a'

hi SignColumn guibg='#191c21'
hi LspErrorVirtualText gui=italic guifg='#6a6d71' guibg=bg
hi LspErrorText gui=bold guifg='#6a6d71'

set signcolumn=yes
