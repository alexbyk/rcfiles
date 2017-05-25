set backupcopy=yes            " for webpack to reload without pain
set dir=~/.vimswap//,/var/tmp//,/tmp//,.
filetype off                  " required ?
set rtp+=~/vundle-plugins/Vundle.vim
call vundle#begin('~/vundle-plugins')

Plugin 'VundleVim/Vundle.vim'

" -------- plugins
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

Plugin 'fatih/vim-go'
let g:go_term_mode="below split"

Plugin 'morhetz/gruvbox'

Plugin 'vim-perl/vim-perl'
let perl_sub_signatures = 1 " signatures

" typescript, requires:
" cd ~/vundle-plugins/vimproc.vim && make
Plugin 'Quramy/tsuquyomi'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'Shougo/vimproc.vim'
Plugin 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1


" npm install -g js-beautify for js
Plugin 'Chiel92/vim-autoformat'
let g:formatdef_my_clang_format = '"clang-format"'
let g:formatters_c = ['my_clang_format']
let g:formatters_java = ['my_clang_format']
let g:formatters_cpp = ['my_clang_format']

let g:formatdef_perltidy = '"perltidy"'
let g:formatters_perl = ['perltidy']
noremap <F2> :Autoformat<CR>

Plugin 'kien/ctrlp.vim'
nnoremap <F5> :CtrlPBuffer<CR>

Plugin 'scrooloose/syntastic'
let g:syntastic_mode_map = { "mode": "active",  "active_filetypes": [],  "passive_filetypes": ["html"] }
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_compiler_options = '-std=gnu11 -Wall -Wextra -pedantic'
let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -pedantic'
let g:syntastic_cpp_compiler = 'clang++'
let $CPATH = $HOME . "/perl5/perlbrew/perls/perl-5.24.0/lib/5.24.0/x86_64-linux/CORE"
let g:syntastic_typescript_tsc_args = '--emitDecoratorMetadata --experimentalDecorators --target=es5 --module=commonjs'
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
nmap <F3> :SyntasticCheck<CR>

Plugin 'pangloss/vim-javascript'

Plugin 'mattn/emmet-vim.git'

Plugin 'scrooloose/nerdtree.git'
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMouseMode=2

Plugin 'taglist.vim'
map <C-l> :TlistToggle<CR>

Plugin 'tomtom/tlib_vim.git'
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'tpope/vim-fugitive.git'
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'

Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<C-J>" " avoid conflicts with YCM
Plugin 'honza/vim-snippets.git'
Plugin 'alexbyk/vim-ultisnips-js-testing'
"Plugin 'alexbyk/vim-ultisnips-react'
Plugin 'alexbyk/vim-ultisnips-perl'

Plugin 'Valloric/YouCompleteMe'
let g:ycm_show_diagnostics_ui = 0 " for syntastic
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
" to close annoying scratch by C-x C-o
"autocmd CompleteDone * pclose

Plugin 'hail2u/vim-css3-syntax'

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
set nu
"set colorcolumn=80
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

"%% in cmd to current dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"=======================================   RUN AND TEST
au Filetype c nmap <F7> :wa<CR>:!make<CR>
au FileType go nmap <F9> :wa<CR><Plug>(go-run)
au FileType go nmap <F7> :wa<CR>:!go run %<CR>
au Filetype cpp nmap <F7> :wa<CR>:!make<CR>
au Filetype javascript nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!node --harmony %; SyntasticToggleMode<CR>
au Filetype typescript nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!tsc --module commonjs --target ES6 --experimentalDecorators --emitDecoratorMetadata % && node --harmony %:r; read <CR>:SyntasticToggleMode<CR>
au Filetype java nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!javac % && java %:r; read<CR>:SyntasticToggleMode<CR>
au Filetype perl nmap <F7> :SyntasticToggleMode<CR>:wa<CR>:!perl -Ilib %<CR>:SyntasticToggleMode<CR>

au Filetype perl nmap <F9> :SyntasticToggleMode<CR>:wa<CR>:!./test.sh -v %<CR>:SyntasticToggleMode<CR>
map <F10> :wa<CR>:!prove -rl t/<CR>

"=======================================   /RUN AND TEST

" ======== Perltidy: Visual mode (vim-autoformat doesnt work for this)
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy
au Filetype perl vmap <F2> :Tidy<CR>

" ====== /Perltidy

" perlcritic
au Filetype perl nmap <F3> :!perlcritic %<CR>

"syntax enable

set background=dark
colorscheme gruvbox
:set mouse=a
