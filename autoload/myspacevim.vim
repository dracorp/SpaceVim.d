scriptencoding utf-8

function! myspacevim#before() abort
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
    let g:OS      = substitute(system('uname'), '\n', '', '')
    let g:pluginIsEnabledVerbose = 0
    let g:bundle_dir = g:spacevim_plugin_bundle_dir . 'repos/github.com'

    if g:MACOS
        let g:python3_host_prog = '/opt/homebrew/bin/python3'
        " let g:python3_host_prog = '/Users/u537501/.pyenv/versions/3.11.6/bin/python'
    endif

    set matchpairs+=<:> " Add HTML brackets to pair matching
    set ignorecase               " ignore case when searching
    " set smartcase                " ignore case if search pattern is all lowercase, case-sensitive otherwise
    " set autoindent                                  " always set autoindenting on
    " set smartindent                                 " smart autoindenting when starting a new line
    " set copyindent                                  " copy the previous indentation on autoindenting
    set nojoinspaces                                " do not insert 2 spaces after .?! when join lines <J>
    set formatoptions+=1                            " long lines are not broken in insert mode
    set formatoptions-=t                            " noautowrap text using textwidth
    set formatoptions-=c                            " autowrap comments using textwidth
    set formatoptions+=o                            " automatically insert the current comment leader after hitting 'o' in Normal mode
    set formatoptions+=r                            " as above but after <Enter> in Insert mode
    "set formatoptions+=m                            " Also break at a multi-byte character above 255
    "set formatoptions+=B                            " When joining lines, don't insert a space between two multi-byte characters
    set complete+=k                                 " scan the files given with the 'dictionary' option
    set splitbelow                                  " command :sp put a new window below the active
    set splitright                                  " command :vs put a new windows on right side of active
    set equalalways                                 " Resize windows on split or close
    set tildeop                                     " Tylde(~) behaves like operator
    set iskeyword-=$
    set iskeyword+=-
    " open file under cursor with env variable
    set isfname+={,}                                " where the file name starts and ends
    " open file under cursor for entry: VARIABLE=path
    set isfname-==
    set whichwrap=b,s,<,>,[,],h,l                   " which keys move the cursor to previous/next line when the cursor is on the first/last character
    set confirm
    set autowrite                                   " write a modified buffer on each :next

    if has('folding')
        set foldenable                              " enable folding
        set foldcolumn=0                            " add a fold column
        set foldmethod=marker                       " detect triple-{ style fold marker
        " set foldmarker={{{,}}}
        set foldlevelstart=1                      " start out with everything unfolded                                                                                             ▼
    endif
    " set wildmode=list:longest,list:full  " show a list when pressing tab and complete
    set noswapfile                  " do not write annoying intermediate swap files
    set nobackup                    " do not keep backup files, it's 70's style cluttering
    set diffopt+=iwhite
    if has("patch-8.1.0360")
        set diffopt+=indent-heuristic
        set diffopt+=internal,algorithm:patience
    endif

    if g:MSWIN64 && has("gui_running")
        au GUIEnter * simalt ~x
    else
        " Maximize GVim on start
        if has("gui_running")
            set lines=999 columns=999
        endif
    endif

    if has("gui_running")
        set guioptions+=t                           " include tearoff menu items
        set guioptions-=T                           " exclude Toolbar
        if g:MSWIN
            set guifont=DejaVu_Sans_Mono:h10:cANSI
        elseif g:MACOS
            set guifont=Hack-Regular:h13
            set guifont=FiraCode-Regular:h13
            set guifont=AgaveNF-Regular:h15
        elseif g:UNIX
            set guifont=Hack\ 13
            set guifont=Cascadia\ Code\ 12
            set guifont=Iosevka\ Semi-Bold\ 12
            set guifont=JetBrains\ Mono\ 12
        endif
    endif
    set list
    set wrap

    " vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot
    let g:polyglot_disabled = ['csv', 'jenkins', 'yaml']
    if filereadable('mappings.vim')
        source mappings.vim
    endif
    if filereadable('functions.vim')
        source functions.vim
    endif
endfunction

function! myspacevim#after() abort
    if filereadable(expand("~/.config/vim/local.vim"))
        source ~/.config/vim/local.vim
    endif
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

    function! VimwikiFindIncompleteTasks() abort
        lvimgrep /- \[ \]/ %:p
        lopen
    endfunction

    function! VimwikiFindAllIncompleteTasks() abort
        VimwikiSearch /- \[ \]/
        lopen
    endfunction

    nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>
    nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>

    " bash-support
    if plugin#isEnabled('vim-scripts/bash-support.vim')
        if g:UNIX
            let g:BASH_LocalTemplateFile = expand("$HOME/.config/vim/templates/bash-support/templates/Templates")
            let g:BASH_CodeSnippets      = expand("$HOME/.config/vim/templates/bash-support/codesnippets")
            let g:BASH_GuiSnippetBrowser = 'commandline'
            if g:MACOS
                let g:BASH_Executable       = '/usr/local/bin/bash'
            else
                let g:BASH_Executable       = '/usr/bin/bash'
            endif
        endif
    endif
    " vim-mundo
    if plugin#isEnabled('simnalamburt/vim-mundo')
        nnoremap <F5> :MundoToggle<cr>
    endif

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
    " nerdtree
    let NERDTreeShowHidden=1

    " vim-commentery
    augroup vim_commentary
        au!
        autocmd FileType apache setlocal commentstring=#\ %s
        autocmd FileType dosini setlocal commentstring=#\ %s
    augroup END

    " perl-support.vim
    if plugin#isEnabled('vim-scripts/perl-support.vim')
        let g:Perl_PerlcriticSeverity  = 1
        let g:Perl_PerlcriticVerbosity = 9
        let g:Perl_PodcheckerWarnings  = 'yes'
    endif

    " taglist.vim
    if plugin#isEnabled('vim-scripts/taglist.vim')
        noremap <silent> <S-F11>       :TlistToggle<CR>
        inoremap <silent> <S-F11>  <C-C>:TlistToggle<CR>
        let tlist_perl_settings = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'
        " fix your ~/.ctags https://gist.github.com/dracorp/5d7308b894c1c9f301bc9cb8d2f262db
        let tlist_sh_settings   = 'sh;f:functions;v:variables;c:constants'
        let Tlist_Enable_Fold_Column=0
        " quit Vim when the TagList window is the last open window
        let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
        let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
        " let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
        " let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
        let Tlist_WinWidth=40               " set the width
        let Tlist_Inc_Winwidth=1            " increase window by 1 when growing
        " shorten the time it takes to highlight the current tag (default is 4 secs)
        " note that this setting influences Vim's behaviour when saving swap files,
        " but we have already turned off swap files (earlier)
        " set updatetime=1000
        " show function/method prototypes in the list
        let Tlist_Display_Prototype=1
        " don't show scope info
        let Tlist_Display_Tag_Scope=1
        " show TagList window on the left
        let Tlist_Use_Left_Window=1
    endif

    " Vista
    noremap  <silent> <S-F12>       :Vista!!<CR>
    inoremap <silent> <S-F12>  <C-C>:Vista!!<CR>
endfunction
