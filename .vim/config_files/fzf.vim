augroup fzf
  autocmd!
augroup END

" Key mapping

" History of file opened
nnoremap <leader>h :History<cr>

" Buffers opens
nnoremap <leader>b :Buffers<cr>

" Files recursively from pwd
nnoremap <leader>f :Files<cr>

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --fixed-strings --hidden --follow --glob="!.git/*" --color="always" --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! RipgrepFzfRegex(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --hidden --follow --glob="!.git/*" --color="always" --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RGr call RipgrepFzfRegex(<q-args>, <bang>0)

nnoremap <leader>a :RG<space>
" Search for word under the cursor
nnoremap <leader>A :exec "RG ".expand("<cword>")<cr>
" Search using regex
nnoremap <leader>r :RGr<space>



let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

nmap <leader><tab> <plug>(fzf-maps-n)
