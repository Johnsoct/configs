" VIM-PLUG BEGIN
" VIM-PLUG BEGIN
" VIM-PLUG BEGIN

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Themes
Plug 'joshdick/onedark.vim'
Plug 'raphamorim/lucario'

call plug#end()

" VIM-PLUG END
" VIM-PLUG END
" VIM-PLUG END

" DEFAULT OVERRIDES BEGIN
" DEFAULT OVERRIDES BEGIN
" DEFAULT OVERRIDES BEGIN

set hls ic
syntax enable
colorscheme onedark 
set clipboard=unnamed
set relativenumber
set re=0

" DEFAULT OVERRIDES END
" DEFAULT OVERRIDES END
" DEFAULT OVERRIDES END

" LINE RULE BEGIN
" LINE RULE BEGIN
" LINE RULE BEGIN

set colorcolumn=80
highlight ColorColumn ctermbg=7 guibg=#898989

" Only show the colorcolumn in the current window
autocmd WinLeave * set colorcolumn=0
autocmd WinEnter * set colorcolumn=+0

" LINE RULE END 
" LINE RULE END 
" LINE RULE END 


" KEYMAPPING BEGIN
" KEYMAPPING BEGIN
" KEYMAPPING BEGIN

let mapleader = " "

" n - mode
" nore - no recursive execution
" map - ... mapping
" <leader>pv - left side of argument, keybind you're creating
" :Vex<CR> - right side of argument, what you're mapping to

" SOURCE CHANGES
nnoremap <nnoremap <leader><cr> :so ~/.vimrc<cr>

" EXIT WHILE INSERTING
inoremap <C-c> <esc>

" FILE EXPLORER
nnoremap <leader>pv :Vex<CR>

" SOURCE CONFIG
nnoremap <leader><CR> :so ~/.vimrc<CR>

" FZF
nnoremap <leader>pf :Files<CR> " Files (junegunn/fzf)
nnoremap <leader>pg :GFiles<CR> " GFiles (junegunn/fzf)
nnoremap <leader>rg :Rg<Space>

" QUICKFIX
nnoremap <C-j> :cnext<CR> " Quickfix next
nnoremap <C-k> :cprev<CR> " Quickfix prev

" KEYMAPPING END 
" KEYMAPPING END 
" KEYMAPPING END 
