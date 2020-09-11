" Make tabs into 4 spaces
set expandtab tabstop=4 shiftwidth=4

set nu
set ruler
set t_Co=256
set hlsearch

" Enable color syntax highlighting
syntax on

" Color scheme
colorscheme jellybeans
highlight Search ctermfg=black ctermbg=darkyellow

set background=dark

" Make comments italic
highlight Comment cterm=italic

" Command Mapping
command Rc source ~/.vimrc

" Command Abbreviations
cnoreabbrev Cs colorscheme


" Vim Pluggins vim-plug
call plug#begin('~/.vim/plugged')


" PEP8 Python Comliance
Plug 'Vimjas/vim-python-pep8-indent'

" Type Script
Plug 'leafgarland/typescript-vim'

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

" Commentary
Plug 'tpope/vim-commentary'

call plug#end() 


" FZF Settings
nmap <c-p> :FZF<CR>
