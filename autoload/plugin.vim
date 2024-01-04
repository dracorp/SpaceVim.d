" Auxilary function to chech if directory of plugin exists and is int runtimepath
" There is side efect with on-demand loading on both conditions

if exists('g:loaded_plugin')
    finish
endif
let g:loaded_plugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

if exists('g:pluginIsEnabledDirectory')
    let s:pluginIsEnabledDirectory = g:pluginIsEnabledDirectory
else
    echoerr('The variable g:pluginIsEnabledDirectory is not defined')
endif

if exists('g:pluginIsEnabledVerbose')
    let s:pluginIsEnabledVerbose = g:pluginIsEnabledVerbose
else
    let s:pluginIsEnabledVerbose = 0
endif

function! plugin#isEnabled(directory, ...) abort
    let l:verbose   = get(a:, 1, 0)
    if stridx(a:directory, '/') >= 0
        let s:directory = split(a:directory, '/')[1]
    else
        let s:directory = a:directory
    endif

    let fullDir = expand(s:pluginIsEnabledDirectory . '/' . a:directory)
    if s:pluginIsEnabledVerbose || l:verbose
        echohl WarningMsg
        echo 'Checking the directory ' . fullDir . ':'
        echohl None
    endif
    let retval = isdirectory(fullDir)
    if !retval
        if s:pluginIsEnabledVerbose || l:verbose
            echohl WarningMsg
            echo '\t* directory does not exist'
            echohl None
        endif
        return retval
    endif
    if s:pluginIsEnabledVerbose || l:verbose
        echo '\t* directory exists'
    endif
    if dein#check_install(s:directory) == 0
        if s:pluginIsEnabledVerbose || l:verbose
            echo '\t* runtimepath contains directory'
        endif
        return 1
    else
        let dict = {}
        for path in split(&runtimepath,',')
            let path = substitute(path,'/$','','')
            let dict[path] = 1
        endfor
        if has_key(dict,fullDir)
            if s:pluginIsEnabledVerbose || l:verbose
                echo '\t* runtimepath contains directory'
            endif
            return 1
        endif
        if s:pluginIsEnabledVerbose || l:verbose
            echohl WarningMsg
            echo '\t* runtimepath does not contain directory'
            echohl None
        endif
        return 0
    endif
endfunction

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
