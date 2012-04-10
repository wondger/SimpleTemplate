"
" @name:wondger<wondger@gmail.com>
" @description:new file from template file
" @date:2012-03-31
" @url:http://wondger.github.com/simpletemplate
" @todo:
"   [X]replace flag in whole file
" @changelog:
"

"setting in vimrc
"there are some system variable you can use in SimpleTemplate
"2012-04-10,#filename#
"let g:SimpleTemplate = {
    "path:$VIM.'/vimfiles/template/',
    "default_name:'noname',
    "cursor:'#cursor#',
    "flags:[
        "{
            "key:'#author#',
            "value:'wondger'
        "},
        "{
            "key:'#date#',
            "value:'#date#'
        "},
        "{
            "key:'#author#',
            "value:'wondger'
        "},
        "{
            "key:'#email#',
            "value:'wondger@gmail.com'
        "},
        "{
            "key:'#url#',
            "value:'http://omiga.org/'
        "}
    "]
"}

let g:SimpleTemplatePath=$VIM.'/vimfiles/template/'
let g:SimpleTemplateName='noname'
let g:SimpleTemplateCursorFlag='#cursor#'
let g:SimpleTemplateFileType='vim'


function! SimpleTemplate(tname,tmode)
    "path
    let tpath = exists('g:SimpleTemplate.path') ? g:SimpleTemplate.path : $VIM.'/vimfiles/template/'
    let g:SimpleTemplatePath = tpath
    let template = tpath.a:tname

    "cursor
    let tcursor= exists('g:SimpleTemplate.cursor') ? g:SimpleTemplate.cursor : g:SimpleTemplateCursorFlag
    let g:SimpleTemplateCursorFlag = tcursor

    "get filetype by postfix
    let mfiletype = matchlist(template,'\.\([^\.]\+\)$')
    let tfiletype = exists('mfiletype[1]') ? mfiletype[1] : g:SimpleTemplateFileType

    let tname = exists('g:SimpleTemplate.default_name') ? g:SimpleTemplate.default_name : ''
    let g:SimplateTemplateName = tname

    if !filereadable(template)
        echo "Template ".template.": not exists!"
        return
    endif

    if a:tmode == 'tab'
        if strlen(tname) && strlen(tfiletype)
            execute 'tabnew '.tname.'.'.tfiletype
        elseif strlen(tfiletype)
            execute 'tabnew '.tname
        else
            tabnew
        endif
    else
        if strlen(tname) && strlen(tfiletype)
            execute 'new '.tname.'.'.tfiletype
        elseif strlen(tfiletype)
            execute 'new '.tname
        else
            tabnew
        endif
    endif

    execute 'setlocal filetype='.tfiletype

    execute 'read '.template

    "delete first line
    normal gg
    delete g

    let flags = exists('g:SimpleTemplate.flags') ? g:SimpleTemplate.flags : []
    for flag in flags
        let value = flag.value

        if flag.value == '#date#'
            let value = strftime('%Y-%m-%d')
        endif

        if flag.value == '#filename#'
            let value = tname.'.'.tfiletype
        endif

        if search(flag.key,'n')
            execute '%s/'.flag.key.'/'.value.'/g'
        endif
    endfor

    let hasCursor = search(g:SimpleTemplateCursorFlag)
    if hasCursor
        let line = getline('.')
        let repl = substitute(line, g:TemplateCursorFlag, '', '')
        call setline('.', repl)
    endif
endfunction

com! -nargs=1 -range=% SimpleTemplate call SimpleTemplate(<f-args>,'window')
if v:version > 700
    com! -nargs=1 -range=% SimpleTemplateTab call SimpleTemplate(<f-args>,'tab')
endif
