set termguicolors
colors base16-gruvbox-dark-hard

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

hi Normal guibg=none
hi Visual guibg='#3a3b3d'
hi EndOfBuffer guifg='#191c21'

hi ColorColumn guibg='#282828'
hi SignColumn guibg=none
hi LineNr guibg=none

set colorcolumn=80
set signcolumn=yes
