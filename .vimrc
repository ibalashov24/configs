" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Cutom Tab settings
"set tabstop=4
" set shiftwidth=4
" set smarttab
" set et
" set nu

" Redefine Tab as 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab  

" Line numbers
set number
set relativenumber

" Thin cursor in insert mode
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
\ if v:insertmode == 'i' | 
\   silent execute '!echo -ne "\e[6 q"' | redraw! |
\ elseif v:insertmode == 'r' |
\   silent execute '!echo -ne "\e[4 q"' | redraw! |
\ endif
au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" Vimspector debugger
";let g:vimspector_enable_mappings = 'HUMAN'
";packadd! vimspector

" Default colorscheme
" colorscheme jellybeans
set t_Co=256
set background=dark
colorscheme PaperColor
set autoindent

" Swap file in separate directory
set backupdir=$HOME/.vim/backup//,.
set directory=$HOME/.vim/backup//,.

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" YouCompleteMe
nmap <leader>d <plug>(YCMHover)
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Vim-plug plugin manager
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'

" Impala
if filereadable(".project.vim")
    source .project.vim
endif

" Code completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ycm-core/YouCompleteMe'

" F# support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}

" C# support
Plug 'OmniSharp/omnisharp-vim'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Error highlighting
Plug 'dense-analysis/ale'

" Latex preview
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Rust
Plug 'rust-lang/rust.vim'
call plug#end()

syntax enable
filetype plugin indent on
