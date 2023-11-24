function! myspacevim#before() abort
    set wrap
    let g:python3_host_prog = '/opt/homebrew/bin/python3'
    " let g:python3_host_prog = '/Users/u537501/.pyenv/versions/3.11.6/bin/python'
endfunction

function! myspacevim#after() abort
    " vimwiki
    let g:vimwiki_list = [
                \ {'path': '~/Documents/vimwiki', 'ext': '.wiki'},
                \ {'path': '~/Projects/Projects-other/shellcheck.wiki/', 'syntax': 'markdown', 'ext': '.md'},
                \ {'path': '~/Projects/Projects-other/awesome-macos-command-line/', 'syntax': 'markdown', 'ext': '.md'},
                \ {'path': '~/Projects/Projects-other/markdown-here.wiki', 'syntax': 'markdown', 'ext': '.md'}
                \]
    let g:vimwiki_global_ext=0
    nmap <Leader>wf <Plug>VimwikiFollowLink
    nmap <Leader>we <Plug>VimwikiSplitLink
    nmap <Leader>vs :vs \| :VimwikiIndex<CR>
    nnoremap <silent> <leader>uu :call vimwiki#base#linkify()<cr>
    nmap <Leader>wq <Plug>VimwikiVSplitLink

    function! VimwikiFindIncompleteTasks()
        lvimgrep /- \[ \]/ %:p
        lopen
    endfunction

    function! VimwikiFindAllIncompleteTasks()
        VimwikiSearch /- \[ \]/
        lopen
    endfunction

    nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>
    nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
endfunction
