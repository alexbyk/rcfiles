set backupcopy=yes            " for webpack to reload without pain
set dir=~/.vimswap//,/var/tmp//,/tmp//,.
filetype off                  " required ?

" to install:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/vim-plugins')

" -------- plugins
Plug 'jiangmiao/auto-pairs'   " () '' {}
Plug 'majutsushi/tagbar'      " definitions/tag tree
map <C-l> :TagbarToggle<CR>
Plug 'othree/html5.vim'       " HTML5 syntax

Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

"------------- GO
Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"
"let g:go_auto_type_info = 1 "show info for functions

autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <leader>b :wa<CR><Plug>(go-build)
autocmd FileType go nmap <leader>r :wa<CR><Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

"------------- /GO

Plug 'AndrewRadev/splitjoin.vim' " split/join struct, html

Plug 'morhetz/gruvbox'  "colorscheme 

Plug 'vim-perl/vim-perl'
let perl_sub_signatures = 1 " signatures

" typescript, requires:
" cd ~/vundle-plugins/vimproc.vim && make
Plug 'Quramy/tsuquyomi'
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

Plug 'Quramy/vim-js-pretty-template'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1


" npm install -g js-beautify for js
Plug 'Chiel92/vim-autoformat'
let g:formatdef_my_clang_format = '"clang-format"'
let g:formatters_c = ['my_clang_format']
let g:formatters_java = ['my_clang_format']
let g:formatters_cpp = ['my_clang_format']

let g:formatdef_perltidy = '"perltidy"'
let g:formatters_perl = ['perltidy']
noremap <F2> :Autoformat<CR>

Plug 'ctrlpvim/ctrlp.vim'
nnoremap <F5> :CtrlPBuffer<CR>

Plug 'scrooloose/syntastic'
let g:syntastic_mode_map = { "mode": "active",  "active_filetypes": [],  "passive_filetypes": ["html"] }
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_compiler_options = '-std=gnu11 -Wall -Wextra -pedantic'
let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -pedantic'
let g:syntastic_cpp_compiler = 'clang++'
" this is for checking XS modules. Will mess with VimPlug(YCM) and other stuff
" let $CPATH = $HOME . "/perl5/perlbrew/perls/perl-5.24.0/lib/5.24.0/x86_64-linux/CORE"
let g:syntastic_typescript_tsc_args = '--emitDecoratorMetadata --experimentalDecorators --target=es5 --module=commonjs'
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
nmap <F3> :SyntasticCheck<CR>

Plug 'pangloss/vim-javascript'

Plug 'mattn/emmet-vim'

Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMouseMode=2         "open folder: 1 click, open file: 2 clicks

"Plug 'taglist.vim' " in favour of majutsushi/tagbar
"map <C-l> :TlistToggle<CR>

Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tpope/vim-fugitive'
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<C-J>" " avoid conflicts with YCM
Plug 'honza/vim-snippets'
Plug 'alexbyk/vim-ultisnips-js-testing'
"Plug 'alexbyk/vim-ultisnips-react' " don't use React anymore
Plug 'alexbyk/vim-ultisnips-perl'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
let g:ycm_show_diagnostics_ui = 0 " for syntastic
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
" to close annoying scratch by C-x C-o
"autocmd CompleteDone * pclose

Plug 'hail2u/vim-css3-syntax'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" -------- /plugins

call plug#end()            " required
" ------------- /VUNDLE



" ---------------- GO TAGS
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }

au BufRead,BufNewFile   *.h set filetype=c " (.h)eaders are C, not C++
au BufRead,BufNewFile   *.t set filetype=perl


" for gf
set path+=$PWD/**,

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set backupdir=/tmp
set nu
"set colorcolumn=80
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

"%% in cmd to current dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"=======================================   RUN AND TEST
au FileType typescript nmap <leader>r :w<CR>:!node_modules/.bin/ts-node %<CR>

au Filetype c nmap <F7> :wa<CR>:!make<CR>
au Filetype cpp nmap <F7> :wa<CR>:!make<CR>
au Filetype javascript nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!node --harmony %; SyntasticToggleMode<CR>
au Filetype java nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!javac % && java %:r; read<CR>:SyntasticToggleMode<CR>
au Filetype perl nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!perl -Ilib %<CR>:SyntasticToggleMode<CR>

au Filetype perl nmap <F9> :SyntasticToggleMode<CR>:wa<CR>:!./test.sh -v %<CR>:SyntasticToggleMode<CR>
au Filetype perl nmap <F10> :wa<CR>:!prove -rl t/<CR>

"=======================================   /RUN AND TEST

" ======== Perltidy: Visual mode (vim-autoformat doesnt work for this)
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy
au Filetype perl vmap <F2> :Tidy<CR>

" ====== /Perltidy

" perlcritic
au Filetype perl nmap <F3> :!perlcritic %<CR>


if has('mouse')
  set mouse=a
endif

"https://github.com/morhetz/gruvbox/wiki/Terminal-specific#0-recommended-neovimvim-true-color-support
if v:progname =~? "nvim"
  set termguicolors
endif
set background=dark
colorscheme gruvbox

if v:progname =~? "evim" || v:progname =~? "nvim"
  finish
endif

" other stuff from default vimrc
" ----------------------------------------------------------------------------------------

""dont remember why but with neovim this causes glitches, so after v:progname check
"syntax enable

set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
