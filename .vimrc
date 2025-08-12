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
"Plug 'Valloric/YouCompleteMe'
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
let g:ycm_confirm_extra_conf = 0

" Coc, for Python Completion and other things
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ALE - Linting
Plug 'w0rp/ale'
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '^'
let g:ale_sign_column_always = 1
let g:ale_linters = {
    \   'python': ['flake8 --ignore=Q000'],
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

" Plug 'davidhalter/jedi-vim'  " XXX Maybe remove?
Plug 'preservim/tagbar'

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

let g:black_linelength = 120
let mapleader = "g"

"" Golang stuff:
let g:go_def_mode='gopls'
let g:go_referrers_mode='gopls'
let g:go_list_type = 'quickfix'
let g:go_list_height = 10  " Hight of things like references
let g:go_list_type = "locationlist"  " Force list to be in same pane/window
autocmd FileType go nmap <leader>r :GoReferrers<CR>
autocmd FileType go nmap <leader>f :GoDecls<CR>
" autocmd FileType go nnoremap <leader>qp :colder<CR>:copen<CR>  " Go to previous quickfix list
" autocmd FileType go nnoremap <leader>qn :cnewer<CR>:copen<CR>  " Go to next quickfix list

" :CocInstall coc-pyright
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> K :call CocAction('doHover')<CR>

" Customize Coc diagnostic colors
"
" guifg: Foreground color for GUI Vim (e.g., #ff5555 is a bright red).
" guibg: Background color (NONE for transparent).
" gui: Style (e.g., underline, bold, italic).
" ctermfg/ctermbg: Colors for terminal Vim (e.g., Red, Yellow).
" cterm: Style for terminal (e.g., underline).
" highlight CocErrorHighlight guifg=#ff5555 guibg=NONE gui=underline ctermfg=Red ctermbg=black cterm=underline
" highlight CocWarningHighlight guifg=#ffaa00 guibg=NONE gui=underline ctermfg=Yellow ctermbg=black cterm=underline
" highlight CocInfoHighlight guifg=#55aaff guibg=NONE gui=underline ctermfg=Red ctermbg=black cterm=underline
" highlight CocHintHighlight guifg=#556655 guibg=NONE gui=underline ctermfg=blue ctermbg=black cterm=underline
highlight CocInlayHint guifg=#888888 guibg=NONE gui=italic ctermfg=Gray ctermbg=NONE cterm=italic

"set foldmethod=indent
nnoremap <space> za

" Tagbar things... 
let g:tagbar_position = 'rightbelow'

" ctags:
set tags=$HOME/ctags


" Map modes
" n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
" i  Insert mode map. Defined using ':imap' or ':inoremap'.
" v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
" x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
" s  Select mode map. Defined using ':smap' or ':snoremap'.
" c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
" o  Operator pending mode map. Defined using ':omap' or ':onoremap'.

" FZF Settings
nmap <c-p> :FZF<CR>

" Tag Jumping and Popping
nmap <c-i> :GoDecls<CR>

" Fix with <C-j> :ts<CR>
nmap <C-j> <C-]>
nmap <C-b> <C-t>
