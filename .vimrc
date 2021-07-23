" Make tabs into 4 spaces
set expandtab tabstop=4 shiftwidth=4

set nu
set ruler
set t_Co=256
set hlsearch

" Enable color syntax highlighting
syntax on

" Make comments italic
"highlight Comment cterm=italic

" Command Mapping
command Rc source ~/.vimrc

" Command Abbreviations
cnoreabbrev Cs colorscheme


" Vim Pluggins vim-plug
call plug#begin('~/.vim/plugged')

" Color Schemes
Plug 'altercation/vim-colors-solarized'

" PEP8 Python Comliance
Plug 'Vimjas/vim-python-pep8-indent'

" Type Script
Plug 'leafgarland/typescript-vim'

" Javascript
Plug 'pangloss/vim-javascript'

" You Complete Me
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
let g:ycm_confirm_extra_conf = 0

" ALE - Linting
Plug 'w0rp/ale'
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '^'
let g:ale_sign_column_always = 1
let g:ale_linters = {
    \   'python': ['flake8'],
    \   'cpp': [],
    \}

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Rtags
Plug 'lyuts/vim-rtags'
let g:rtagsRcCmd = "/usr/local/bin/rc"

" Ctags
Plug 'universal-ctags/ctags'

" Commentary
Plug 'tpope/vim-commentary'

" Clang auto-formatting
"Plug 'cjuniet/clang-format.vim'
Plug 'rhysd/vim-clang-format'
" let g:clang_format#auto_format=1

" Auto-formatting for Python
"Plug 'python/black'

" Tag Browser
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }  " browse symbols

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


call plug#end() 

" Yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Colorschemes
" Solarized:
colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_visibity="high"
let g:solarized_contrast="high"

set background=dark


let g:black_linelength = 100


" FZF Settings
nmap <c-p> :FZF<CR>

" Tag Jumping and Popping
nmap <c-i> :GoDecls<CR>

" ctags:
set tags=$HOME/ctags
" Fix with <C-j> :ts<CR>
nnoremap <C-j> <C-]>
nnoremap <C-b> <C-t>
