"Vundle Init
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"------------------------------------------------------------------------------

" General enhancements
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'altercation/vim-colors-solarized'

"-------------------------------------------------------------------------------
"Vundle Cleanup
call vundle#end()
filetype plugin indent on

"-------------------------------------------------------------------------------
" General settings
set background=dark

filetype plugin indent on
syntax on

set number
set ts=4 sts=4 sw=4 expandtab

set hidden
set noswapfile
set history=9999
set hlsearch
set nowrap


" ColorColumn, red is nasty.
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
set colorcolumn=80


" Paste Toggle
set pastetoggle=<F11>


" Folding
nnoremap <Space> za
vnoremap <Space> za
nnoremap <leader>z zMzvzz


" Change local directory
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>
nnoremap <leader>-- :lcd ..<CR>:pwd<CR>


if has("autocmd")
  " Fugitive
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Override tab style by file types
  autocmd Filetype sh setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype scala setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype cpp setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype json setlocal ts=2 sts=2 sw=2 expandtab
endif

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


" iTerm2 and tmux, insert mode cursor settings
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end


" YouCompleteMe
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_goto_buffer_command = 'vertical-split'


" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" Syntastic configurations
let g:syntastic_python_checkers = ['flake8']


" ack.vim + the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  nnoremap <leader>aa :Ack! --literal<Space>
  nnoremap <leader>aw :Ack! --literal '<C-R><C-W>'<CR>
  vnoremap <leader>av y:Ack! --literal '<C-R>"'<CR>
endif


"vim-jekyll configuration
let g:jekyll_post_extension = '.md'
let g:jekyll_post_template =  [
  \ '---',
  \ 'title: "JEKYLL_TITLE"',
  \ 'updated: "JEKYLL_DATE"',
  \ '---',
  \ '']
