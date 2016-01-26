set nocompatible              " be iMproved, required
set backupcopy=yes            " for webpack to reload without pain
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" -------- plugins
Plugin 'vim-perl/vim-perl'
Plugin 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1

"Plugin 'mxw/vim-jsx'
"let g:jsx_ext_required = 0

" npm install -g js-beautify for js
Plugin 'Chiel92/vim-autoformat'
let g:formatdef_my_clang_format = '"clang-format-3.6"'
let g:formatters_c = ['my_clang_format']
let g:formatters_java = ['my_clang_format']
let g:formatters_cpp = ['my_clang_format']

"let g:formatdef_my_jsx = '"js-beautify -X -f - -".(&expandtab ? "s ".&shiftwidth : "t").(&textwidth ? " -w ".&textwidth : "")'
"let g:formatters_javascript_jsx = ['my_jsx']

let g:formatdef_perltidy = '"perltidy"'
let g:formatters_perl = ['perltidy']
noremap <F2> :Autoformat<CR>

Plugin 'kchmck/vim-coffee-script'

Plugin 'kien/ctrlp.vim'
nnoremap <F5> :CtrlPBuffer<CR>

"color theme
Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/syntastic'
let g:syntastic_mode_map = { "mode": "active",  "active_filetypes": [],  "passive_filetypes": ["html"] }
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_compiler_options = '-std=gnu11 -Wall -Wextra -pedantic'
let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -pedantic'
let g:syntastic_cpp_compiler = 'clang++'
let $CPATH = $HOME . "/perl5/perlbrew/perls/perl-5.22.0/lib/5.22.0/x86_64-linux/CORE"
"let g:syntastic_javascript_checkers = ['eslint']
nmap <F3> :SyntasticCheck<CR>

Plugin 'pangloss/vim-javascript'

Plugin 'mattn/emmet-vim.git'

Plugin 'scrooloose/nerdtree.git'
map <C-n> :NERDTreeToggle<CR>

Plugin 'taglist.vim'
map <C-l> :TlistToggle<CR>

Plugin 'tomtom/tlib_vim.git'
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'tpope/vim-fugitive.git'
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

Plugin 'tpope/vim-repeat.git'

Plugin 'tpope/vim-surround.git'

Plugin 'sukima/xmledit.git'
let g:xmledit_enable_html=1

Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<C-J>" " avoid conflicts with YCM
Plugin 'honza/vim-snippets.git'
Plugin 'alexbyk/vim-ultisnips-mocha'
Plugin 'alexbyk/vim-ultisnips-react'
Plugin 'alexbyk/vim-ultisnips-perl'

Plugin 'Valloric/YouCompleteMe'
" for syntastic
let g:ycm_show_diagnostics_ui = 0
" -------- /plugins

call vundle#end()            " required
filetype plugin indent on    " required
" ------------- /VUNDLE

" (.h)eaders are C, not C++
au BufRead,BufNewFile   *.h set filetype=c
au BufRead,BufNewFile   *.t set filetype=perl


" for gf
set path+=$PWD/**,

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set backupdir=/tmp
highlight LineNr ctermfg=darkgrey
set nu
set colorcolumn=80
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

"%% in cmd to current dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"=======================================   RUN AND TEST
au Filetype c map <F7> :wa<CR>:!make<CR>
au Filetype cpp map <F7> :wa<CR>:!make<CR>
"au Filetype javascript map <F7> :SyntasticToggleMode<CR>:wa<CR>:!babel-node %; read <CR>:SyntasticToggleMode<CR>
au Filetype typescript map <F7> :SyntasticToggleMode<CR>:wa<CR>:!tsc --module commonjs % && node %:r; read <CR>:SyntasticToggleMode<CR>
au Filetype java map <F7> :SyntasticToggleMode<CR>:wa<CR>:!javac % && java %:r; read <CR>:SyntasticToggleMode<CR>
au Filetype perl map <F7> :SyntasticToggleMode<CR>:wa<CR>:!perl -Ilib %; read<CR>:SyntasticToggleMode<CR>

au Filetype perl map <F9> :SyntasticToggleMode<CR>:wa<CR>:!prove -I ../common/lib -I local/lib/perl5 -rlv %<CR>:!read<CR>:SyntasticToggleMode<CR>
nnoremap <F10> :wa<CR>:!prove -rl t/<CR>

"=======================================   /RUN AND TEST

" ======== Perltidy: Visual mode (vim-autoformat doesnt work for this)
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy
au Filetype perl vmap <F2> :Tidy<CR>

" ====== /Perltidy

" perlcritic
au Filetype perl nmap <F3> :!perlcritic %<CR>

" gui
if has("gui_running") 
  set go=m
  syntax enable
  set background=dark
  colorscheme solarized
else 
  " fix C_O delay
  set ttimeoutlen=100
endif


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif



" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	"syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
	"filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif





