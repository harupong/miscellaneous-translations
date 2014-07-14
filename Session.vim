let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
cmap <S-Insert> +
imap <S-Insert> 
nmap  "+gP
omap  "+gP
vmap  "*d
map Q gq
nmap gx <Plug>NetrwBrowseX
nnoremap j gj
nnoremap k gk
nmap mx <Plug>ClearAllBookmarks
nmap mc <Plug>ClearBookmarks
nmap mp <Plug>PrevBookmark
nmap mn <Plug>NextBookmark
nmap mi <Plug>Annotate
nmap mm <Plug>ToggleBookmark
nmap ma <Plug>ShowAllBookmarks
nnoremap scb :set scrollbind! scrollbind?
nnoremap sc <Nop>
nnoremap ss :sp
nnoremap sv :vs
nnoremap sh h
nnoremap sl l
nnoremap sk k
nnoremap sj j
nnoremap s <Nop>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap <silent> <Plug>ClearAllBookmarks :ClearAllBookmarks
nnoremap <silent> <Plug>ClearBookmarks :ClearBookmarks
nnoremap <silent> <Plug>PrevBookmark :PrevBookmark
nnoremap <silent> <Plug>NextBookmark :NextBookmark
nnoremap <silent> <Plug>Annotate :Annotate
nnoremap <silent> <Plug>ToggleBookmark :ToggleBookmark
nnoremap <silent> <Plug>ShowAllBookmarks :ShowAllBookmarks
nnoremap <Up> gk
nnoremap <Down> gj
vmap <S-Insert> 
vmap <C-Del> "*d
vmap <S-Del> "*d
vmap <C-Insert> "*y
nmap <S-Insert> "+gP
omap <S-Insert> "+gP
inoremap  u
cmap  +
let &cpo=s:cpo_save
unlet s:cpo_save
set ambiwidth=double
set autoindent
set background=dark
set backspace=indent,eol,start
set backup
set backupdir=~\\vim/vimfiles/backups
set clipboard=unnamed
set cmdheight=2
set directory=~\\vim/vimfiles/backups
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,utf-8,cp932,euc-jp,default,latin
set guifont=MigMix\ 1M:h12
set guifontwide=MigMix\ 1M:h12
set helplang=ja
set hidden
set history=1000
set ignorecase
set incsearch
set laststatus=2
set matchpairs=(:),{:},[:],<:>
set previewheight=40
set ruler
set runtimepath=~/vimfiles,~\\vim/vimfiles,~\\vim\\vimfiles\\bundle\\neomru.vim,~\\vim\\vimfiles\\bundle\\unite.vim,~\\vim\\vimfiles\\bundle\\vim-bookmarks,~\\vim\\vimfiles\\bundle\\vim-markdown,~\\vim\\vim74,~\\vim\\vimfiles\\bundle\\vim-markdown\\after,~\\vim/vimfiles/after,~/vimfiles/after
set shiftround
set shiftwidth=2
set showmatch
set smartcase
set smartindent
set statusline=%3n\ %<%f\ %m%r%h%w%{\"[\"\ .\ (&fileencoding\ !=\ \"\"\ ?\ &fileencoding\ :\ &encoding)\ .\ \"]\"}%{\"[\"\ .\ &fileformat\ .\ \"]\"}%{\"[\"\ .\ &filetype\ .\ \"]\"}%=%l,%c%V%4P
set tabstop=2
set title
set viminfo='100,<50,s10,h,rA:,rB:,n$VIM/_viminfo
set whichwrap=b,s,<,>,[,],h,l
set wildmenu
set window=32
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~\Documents\Git\miscellaneous-translations
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 app-review-should-test-accessibility-ja.md
badd +1 app-review-should-test-accessibility.md
args app-review-should-test-accessibility-ja.md app-review-should-test-accessibility.md
edit app-review-should-test-accessibility.md
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 10 + 16) / 33)
exe '2resize ' . ((&lines * 19 + 16) / 33)
argglobal
edit app-review-should-test-accessibility.md
nnoremap <buffer> <silent> [] :call b:Markdown_MoveToPreviousSiblingHeader()
nnoremap <buffer> <silent> [[ :call b:Markdown_MoveToPreviousHeader()
nnoremap <buffer> <silent> ]c :call b:Markdown_MoveToCurHeader()
nnoremap <buffer> <silent> ]u :call b:Markdown_MoveToParentHeader()
nnoremap <buffer> <silent> ][ :call b:Markdown_MoveToNextSiblingHeader()
nnoremap <buffer> <silent> ]] :call b:Markdown_MoveToNextHeader()
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=b:*,b:+,b:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'mkd'
setlocal filetype=mkd
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqr
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,128-167,224-235
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal smartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'mkd'
setlocal syntax=mkd
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit app-review-should-test-accessibility-ja.md
nnoremap <buffer> <silent> [] :call b:Markdown_MoveToPreviousSiblingHeader()
nnoremap <buffer> <silent> [[ :call b:Markdown_MoveToPreviousHeader()
nnoremap <buffer> <silent> ]c :call b:Markdown_MoveToCurHeader()
nnoremap <buffer> <silent> ]u :call b:Markdown_MoveToParentHeader()
nnoremap <buffer> <silent> ][ :call b:Markdown_MoveToNextSiblingHeader()
nnoremap <buffer> <silent> ]] :call b:Markdown_MoveToNextHeader()
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=b:*,b:+,b:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'mkd'
setlocal filetype=mkd
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqr
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,128-167,224-235
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal smartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'mkd'
setlocal syntax=mkd
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 10 - ((9 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 10 + 16) / 33)
exe '2resize ' . ((&lines * 19 + 16) / 33)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
