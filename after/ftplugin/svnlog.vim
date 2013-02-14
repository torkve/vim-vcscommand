" Vim script file                                           vim:fdm=marker:
" FileType:     SvnLog
" Author:       Vsevolod Velichko <torkvema@gmail.com>
" Maintainer:   Vsevolod Velichko <torkvema@gmail.com>
" Last Change:  Date: 2013-02-13
" Version:      Revision: 1.0
"
" Licence:      This program is free software; you can redistribute it
"               and/or modify it under the terms of the GNU General Public
"               License.  See http://www.gnu.org/copyleft/gpl.txt

function! s:GetRelPath(filename)
    let l:svnInfo = system("LANG=C svn info")
    let l:root = matchlist(l:svnInfo, "Repository Root: \\([^\n]\\+\\)")[1]
    let l:url = matchlist(l:svnInfo, "URL: \\([^\n]\\+\\)")[1]
    let l:fullPath = l:root . a:filename
    return l:fullPath[strlen(l:url)+1:]
endfunction

function! GetSvnDiff()
    let l:curline = getline('.')
    let l:fmatch = matchlist(l:curline, '^\s*[DAM] \(/[^()]\+\)')
    if l:fmatch == []
        let l:filename = ''
    else
        let l:filename = s:GetRelPath(l:fmatch[1])
    endif
    let l:revisionLine = search('^r\d\+ ', "bncW")
    if l:revisionLine == 0
        return
    endif
    let l:revision = matchlist(getline(l:revisionLine), '^r\(\d\+\)')[1]
    exec "VCSDiff -c" . l:revision . " " . l:filename
endfunction

nmap <cr> :call GetSvnDiff()<cr>
setlocal foldmethod=syntax
