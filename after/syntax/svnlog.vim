" Vim syntax file
" Language:	SVN log output
" Maintainer:	Vsevolod Velichko <torkvema@gmail.com>
" Remark:	Used by the vcscommand plugin.
" License:
" Copyright (c) 2013 Vsevolod Velichko
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
" IN THE SOFTWARE.

if exists("b:current_syntax")
	finish
endif

syn case match
syn sync minlines=100

syn region      svnCommit       transparent start=/^r\d\+ / end=/^-\{72}$/                      contains=svnHead,svnModification fold
" Head line, e.g.:
" r123456 | vasya123 | 2013-02-10 22:36:08 +0400 (Вс., 10 февр. 2013) | 1 line
syn match       svnHead         transparent contained /^r\d\+ | \S\+ | [^|]* | \d\+ lines\?$/   contains=svnRevision,svnAuthor,svnDate,svnNumLines
syn match       svnAuthor       display contained /\S\+/                                        contains=NONE nextgroup=svnDate skipwhite
syn match       svnDate         display contained /\d[0-9:+ -]\{3,}[^|]*/he=e-1                 contains=NONE
syn match       svnNumLines     display contained /\d\+ lines\?$/                               contains=NONE
syn match       svnRevision     display contained /\<r\d\+\>/                                   contains=NONE nextgroup=svnAuthor skipwhite

" Modification line, e.g.:
"     M /trunk/path/to/file.vim
syn match       svnModification transparent contained /^\s\+[DAM] .\+$/                         contains=svnModFlag,svnFilePath,svnFileMove
syn match       svnFilePath     display contained "/[^()]\+"                                    contains=NONE
syn match       svnFileMove     display contained "/.\+ (from /.\+)"                            contains=svnFilePath skipwhite
syn match       svnModFlag      display contained /[DAM]/                                       contains=NONE nextgroup=svnFilepath skipwhite

hi link svnRevision     Type
hi link svnAuthor       Statement
hi link svnDate         Number

hi link svnModFlag      LineNr
hi link svnFilePath     Directory
hi link svnFileFrom     Error
hi link svnFileMove     Error

let b:current_syntax="svnlog"
