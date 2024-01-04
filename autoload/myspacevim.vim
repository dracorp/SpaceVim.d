scriptencoding utf-8

function! myspacevim#before() abort "{{{
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
    " for plugin.vim
    let g:pluginIsEnabledVerbose = 0
    let g:pluginIsEnabledDirectory = g:spacevim_plugin_bundle_dir . 'repos/github.com'
    " for loading configuration from files
    let $VIM_HOME=$HOME.'/.SpaceVim.d'

    if g:MACOS
        " let g:python3_host_prog = '/opt/homebrew/bin/python3'
        let g:python3_host_prog=substitute(system('which python3'), '\n', '', 'g')
        " let g:python3_host_prog = '/Users/u537501/.pyenv/versions/3.11.6/bin/python'
    endif

    " Add HTML brackets to pair matching
    set matchpairs+=<:>
    " ignore case when searching
    set ignorecase
    " ignore case if search pattern is all lowercase, case-sensitive otherwise
    " set smartcase
    " always set autoindenting on
    " set autoindent
    " smart autoindenting when starting a new line
    " set smartindent
    " copy the previous indentation on autoindenting
    " set copyindent
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
    set iskeyword+=-,#
    " open file under cursor with env variable
    set isfname+={,}                                " where the file name starts and ends
    " open file under cursor for entry: VARIABLE=path
    set isfname-==
    set whichwrap=b,s,<,>,[,],h,l                   " which keys move the cursor to previous/next line when the cursor is on the first/last character
    set confirm
    set autowrite                                   " write a modified buffer on each :next
    " set wildmode=list:longest,list:full  " show a list when pressing tab and complete
    set noswapfile                  " do not write annoying intermediate swap files
    set nobackup                    " do not keep backup files, it's 70's style cluttering

    if has('folding')
        set foldenable                              " enable folding
        set foldcolumn=0                            " add a fold column
        set foldmethod=marker                       " detect triple-{ style fold marker
        " set foldmarker={{{,}}}
        set foldlevelstart=1                      " start out with everything unfolded
        " Don't open folds when search into them
        set foldopen-=search
        " Don't open folds when undo stuff
        set foldopen-=undo

        " Mappings to easily toggle fold levels
        nnoremap z0 :set foldlevel=0<cr>
        nnoremap z1 :set foldlevel=1<cr>
        nnoremap z2 :set foldlevel=2<cr>
        nnoremap z3 :set foldlevel=3<cr>
        nnoremap z4 :set foldlevel=4<cr>
        nnoremap z5 :set foldlevel=5<cr>
    endif

    set diffopt+=iwhite
    if has('patch-8.1.0360')
        set diffopt+=indent-heuristic
        set diffopt+=internal,algorithm:patience
    endif

    if g:MSWIN64 && has('gui_running')
        augroup WIN
            au!
            au GUIEnter * simalt ~x
        augroup END
    else
        " Maximize GVim on start
        if has('gui_running')
            set lines=999 columns=999
        endif
    endif

    if has('gui_running')
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
    " Add empty newlines at the end of files
    set endofline

    " vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot
    let g:polyglot_disabled = ['csv', 'jenkins', 'yaml']
endfunction "}}}

function! myspacevim#after() abort "{{{
    unmap <
    unmap >
    unmap <F2>
"" Theme: Gruvbox {{{
    " Set option value to 16 to fallback
    let g:gruvbox_termcolors=256
    " Change darkmode contrast. Possible values are `soft`, `medium`, `hard`
    let g:gruvbox_contrast_dark='medium'
    " Change lightmode contrast. Possible values are `soft`, `medium`, `hard`
    let g:gruvbox_contrast_light='hard'
    " Change cursor background
    let g:gruvbox_hls_cursor='green'
    " Inverts indent guides
    let g:gruvbox_invert_indent_guides=0
"" }}}

"" Plugin: vimwiki {{{
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
"" }}}

"" Plugin: bash-support {{{
    if plugin#isEnabled('vim-scripts/bash-support.vim')
        if g:UNIX
            let g:BASH_LocalTemplateFile = expand('$VIM_HOME/templates/bash-support/templates/Templates')
            let g:BASH_CodeSnippets      = expand('$VIM_HOME/templates/bash-support/codesnippets')
            let g:BASH_GuiSnippetBrowser = 'commandline'
            if g:MACOS
                let g:BASH_Executable       = '/usr/local/bin/bash'
            else
                let g:BASH_Executable       = '/usr/bin/bash'
            endif
        endif
    endif
"" }}}

"" Plugin: vim-mundo {{{
    if plugin#isEnabled('simnalamburt/vim-mundo')
        nnoremap <F5> :MundoToggle<cr>
    endif
"" }}}

"" Plugin: nerd-commenter {{{
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
"" }}}

"" Plugin: NERDTree {{{
    let NERDTreeShowHidden=1
"" }}}

"" Plugin: vim-commentery {{{
    augroup vim_commentary
        au!
        autocmd FileType apache setlocal commentstring=#\ %s
        autocmd FileType dosini setlocal commentstring=#\ %s
    augroup END
"" }}}

"" Plugin: perl-support.vim {{{
    if plugin#isEnabled('vim-scripts/perl-support.vim')
        let g:Perl_PerlcriticSeverity  = 1
        let g:Perl_PerlcriticVerbosity = 9
        let g:Perl_PodcheckerWarnings  = 'yes'
    endif
"" }}}

"" Plugin: taglist.vim {{{
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
"" }}}

"" Plugin: Vista {{{
    noremap  <silent> <S-F12>       :Vista!!<CR>
    inoremap <silent> <S-F12>  <C-C>:Vista!!<CR>
"" }}}

"" Plugin: Github Dashboard {{{
    "" GitHub Public
    let g:github_dashboard={}
    let g:github_dashboard['username']='dracorp'
    " Set shortcut for GitHub Dashboard
    nnoremap <Leader>ghd :GHDashboard<CR>
    nnoremap <Leader>gha :GHActivity<CR>
    nnoremap <Leader>ghD :GHDashboard<space>
    nnoremap <Leader>ghA :GHActivity<space>

    "" GitHub Enterprise
    " let g:github_dashboard#private={}
    " let g:github_dashboard#private['username']='posquit0'
    " Configure default GitHub endpoints
    " let g:github_dashboard#private['api_endpoint']='https://github.private.com/api/v3'
    " let g:github_dashboard#private['web_endpoint']='https://github.private.com'
"" }}}

"" Plugin: Colorizer {{{
  " Method to highlight
  let g:Hexokinase_highlighters=['backgroundfull']
  " Patterns to match for all filetypes
  let g:Hexokinase_optInPatterns = [
  \ 'full_hex',
  \ 'triple_hex',
  \ 'rgb',
  \ 'rgba',
  \ 'hsl',
  \ 'hsla',
  \ 'colour_names'
  \ ]
"" }}}

"" Plugin: Vim Multiple Cursors {{{
  " Turn off the default key bindings
  let g:multi_cursor_use_default_mapping=0
  " Configure custom key bindings
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'
  " Quit and delete all existing cursor in visual mode after pressing quit key
  let g:multi_cursor_exit_from_visual_mode=1
  " Quit and delete all existing cursor in insert mode after pressing quit key
  let g:multi_cursor_exit_from_insert_mode=0
"" }}}

"" Plugin: NERD Commenter {{{
  " Comment the whole lines in visual mode
  let g:NERDCommentWholeLinesInVMode=1
  " Add space after the left delimiter and before the right delimiter
  let g:NERDSpaceDelims=1
  " Use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs=1
  " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDCommentEmptyLines=1
  " Enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace=1
"" }}}

"" Plugin: Context {{{
  " Whether to enable the context plugin
  let g:context_enabled=1
  " INFO: Issue in Neovim which leads to some artefacts
  let g:context_nvim_no_redraw=1
" }}}

"" Additional Configs {{{
  " Configurations for plugins to load into Vim
  let plugin_configurations=[
  \ 'functions.vim',
  \ ]
    for configuration in plugin_configurations
        let config_path = join([$VIM_HOME, 'autoload', configuration], '/')
        if filereadable(config_path)
            execute 'source ' . config_path
        endif
    endfor
    if filereadable(expand('~/.config/vim/local.vim'))
        source ~/.config/vim/local.vim
    endif
"" }}}

"| Recursive | Non-recursive | Unmap    | Modes                            |
"|-----------|--------------------------|----------------------------------|
"| :map      | :noremap      | :unmap   | normal, visual, operator-pending |
"| :nmap     | :nnoremap     | :nunmap  | normal                           |
"| :xmap     | :xnoremap     | :xunmap  | visual                           |
"| :cmap     | :cnoremap     | :cunmap  | command-line                     |
"| :omap     | :onoremap     | :ounmap  | operator-pending                 |
"| :imap     | :inoremap     | :iunmap  | insert                           |

" !         make a switch from a key
" <CR>      Enter key
" <C-o>     allows in 'insert' mode insert a command
" <silent>  a mapping will not be echoed on the command line
" %         actual file, :he expand
" <leader>  default \

" Leader {{{

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>
" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" highlight line under cursor, horizontal cursor
nnoremap <Leader>l :setlocal cursorline!<CR>
nnoremap <Leader>L :setlocal cursorcolumn!<CR>


" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

nnoremap <Leader>H :set hlsearch!<CR>

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l
" }}}

" change search mapping and don't jump {{{
" nnoremap * g#``
" nnoremap # g*``
" nnoremap g* #``
" nnoremap g# *``

" nnoremap * g*``
" nnoremap # g#``
" nnoremap g* *``
" nnoremap g# #``
"}}}
" Turn off hlsearch
" nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" nnoremap n nzzzv
" nnoremap N Nzzzv

" Function keys
" refresh syntax highlight
 noremap <silent> <F10> <Esc>:syntax sync fromstart<CR>
inoremap <silent> <F10> <C-o>:syntax sync fromstart<CR>

" Permanent 'very magic' mode, see :he pattern
" search, broken history search!
" nnoremap / /\v
" vnoremap / /\v
" substitute
" cnoremap %s/ %smagic/
" cnoremap %s# %smagic#
" substitute in visual mode
" cnoremap \>s/ \>smagic/
" cnoremap \>s# \>smagic#
" global
" nnoremap :g/ :g/\v
" nnoremap :g// :g//

" paste mode, where you can paste mass data
" that won't be autoindented
" set pastetoggle=<S-F6>                         " deprecated: replaced by vim-bracketed-paste plugin

" open file under cursors in a new window (a vertical split)
map <c-w>F :vertical wincmd f<CR>

" Speed up scrolling of the viewport slightly
" nnoremap <C-e> 2<C-e>
" nnoremap <C-y> 2<C-y>

" C-U in insert/normal mode, to uppercase the word under cursor
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe
" C-L in insert/normal mode, to lowercase the word under cursor
inoremap <c-l> <esc>viwuea
nnoremap <c-l> viwue

" Use Q for formatting the current paragraph (or visual selection)
" vnoremap Q gq
" nnoremap Q gqap

" map zp :setlocal spell!<CR>
" imap zP <ESC>:setlocal spell!<CR>i<right>

if g:MACOS
    " Coping
    vnoremap <C-Help> "+y
    " Pasting
    inoremap <S-Help> "+gP
    " Cutting
    vnoremap <C-S-Help> "+x
endif

" search for visually highlighted text
"vmap // y/<C-R>"<CR>
"with spec chars
vmap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" autocomplete parenthesis, (brackets) and braces
"inoremap  (  ()<Left>
"inoremap  [  []<Left>
"inoremap  {  {}<Left>

"vnoremap  (  s()<Esc>P<Right>%
"vnoremap  [  s[]<Esc>P<Right>%
"vnoremap  {  s{}<Esc>P<Right>%

" autocomplete quotes (visual and select mode)
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>

" Moving cursor to other windows:
" shift down   : change window focus to lower one (cyclic)
" shift up     : change window focus to upper one (cyclic)
" shift left   : change window focus to one on left
" shift right  : change window focus to one on right
nnoremap <s-down>   <c-w>w
nnoremap <s-up>     <c-w>W
nnoremap <s-left>   <c-w>h
nnoremap <s-right>  <c-w>l

" Navigate on a wrapped line as the normal
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Up> <C-o>gk
inoremap <Up> <C-o>gk

" tab pages
" nnoremap <c-TAB> :tabnext<cr>
" nnoremap <c-s-TAB> :tabprev<cr>

" Use shift-H and shift-L for move to beginning/end
" nnoremap H 0
" nnoremap L $
"
" map <ESC>[H <Home>
" map <ESC>[F <End>
" imap <ESC>[H <C-O><Home>
" imap <ESC>[F <C-O><End>
" cmap <ESC>[H <Home>
" cmap <ESC>[F <End>
endfunction "}}}
