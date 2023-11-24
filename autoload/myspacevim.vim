function! myspacevim#before() abort
    set wrap
    let g:python3_host_prog = '/opt/homebrew/bin/python3'
    " let g:python3_host_prog = '/Users/u537501/.pyenv/versions/3.11.6/bin/python'
endfunction

function! myspacevim#after() abort
    let g:MSWIN   = has('win16')  || has('win32')   || has('win64')     || has('win95')
    let g:MSWIN64 = has('win64')
    let g:UNIX    = has('unix')   || has('macunix') || has('win32unix')
    let g:MACOS   = has('mac')
    let g:PYTHON3 = has('python3')
    let g:PYTHON  = has('python') || has('python3')
    " Note: for proper work with pythonX on MacOs with nvim install:
    " brew install python
    " brew install python3
    " pip2 install neovim --upgrade
    " pip3 install neovim --upgrade
    let g:OS      = substitute(system('uname'), "\n", "", "")

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

    " bash-support
    if g:UNIX
      " let g:BASH_LocalTemplateFile    = vimrc_dir . 'templates/bash-support/templates/Templates'
      " let g:BASH_GuiSnippetBrowser = 'commandline'
      if g:MACOS
          let g:BASH_Executable       = '/usr/local/bin/bash'
      else
          let g:BASH_Executable       = '/usr/bin/bash'
      endif
    endif
    " vim-mundo
    nnoremap <F5> :MundoToggle<cr>

    " nerd-commenter
          " Add spaces after comment delimiters by default
      let g:NERDSpaceDelims = 1
      " Use compact syntax for prettified multi-line comments
      let g:NERDCompactSexyComs = 1
      " Align line-wise comment delimiters flush left instead of following code indentation
      let g:NERDDefaultAlign = 'left'
      " Set a language to use its alternate delimiters by default
      let g:NERDAltDelims_java = 1
      " Allow commenting and inverting empty lines (useful when commenting a region)
      let g:NERDCommentEmptyLines = 1
      " Enable trimming of trailing whitespace when uncommenting
      let g:NERDTrimTrailingWhitespace = 1
      " Enable NERDCommenterToggle to check all selected lines is commented or not
      let g:NERDToggleCheckAllLines = 1
      let g:NERDCustomDelimiters = {
          \ 'brewfile': { 'left': '#','right': '' }
      \ }

      " vim-commentery
      autocmd FileType apache setlocal commentstring=#\ %s
      autocmd FileType dosini setlocal commentstring=#\ %s
endfunction
