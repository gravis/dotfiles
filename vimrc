" vundle config (https://github.com/gmarik/vundle)
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My bundles
Bundle 'Vimball'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-bundler'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-markdown'
Bundle 'mklabs/vim-backbone'
Bundle 'tComment'
Bundle 'jnwhiteh/vim-golang'
Bundle 'vim-json-bundle'
Bundle 'Blackrush/vim-gocode'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'Townk/vim-autoclose'
Bundle 'scrooloose/syntastic'

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
filetype plugin on

" remap leader to a french key:
let mapleader = ","

" Use case-smart searching
" These two options, when set together, will make /-style searches
" case-sensitive only if there is a capital letter in the search expression.
" *-style searches continue to be consistently case-sensitive.
set ignorecase
set smartcase

" Maintain more context around the cursor :
set scrolloff=3

" Store temporary files in a central spot
set backupdir=~/.vim/swp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/swp,~/.tmp,~/tmp,/var/tmp,/tmp

" Enable limited line numbering
set ruler

" rails config
set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
 	" Clear old autocmds in group
 	autocmd!
 	" autoindent with two spaces, always expand tabs
 	autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

" auto indenter
nmap <leader>rci :%!ruby-code-indenter<cr> 


set laststatus=2
set mouse=a
set list listchars=tab:>-,trail:.
:highlight SpecialKey ctermfg=darkgrey

set incsearch " do incremental searching

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 
map <Leader>r :Rake<cr>

set hlsearch
" Set Ack as the default grep program
set grepprg=ack
set grepformat=%f:%l:%m

" Auto save files when focus is lost
:au FocusLost * :wa
" :setlocal spell spelllang=fr

autocmd BufRead,BufNewFile *.ru,*.task set filetype=ruby

" Remove trailing spaces with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Add Rfactory command with dynamic search
autocmd User Rails silent! Rnavcommand factory test/factories -suffix=.rb
autocmd User Rails silent! Rnavcommand feature features -suffix=.feature
autocmd User Rails silent! Rnavcommand step features/step_definitions -suffix=.rb
autocmd User Rails silent! Rnavcommand job app/jobs -suffix=.rb
autocmd User Rails silent! Rnavcommand sql sql -suffix=.sql

map <C-h> <C-]>

" ColorScheme : IR BLACK
colorscheme ir_black


" Consider scss files as css files
au BufRead,BufNewFile *.scss set filetype=css

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line
  set statusline=%f\ %m\ %r

  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=\ Col:%v
  set statusline+=\ [%b][0x%B]
endif

" RUBY
" =========================================
" set compiler for ruby
autocmd FileType ruby compiler ruby

" GO
" =========================================
" Config for GO files
autocmd FileType go  set makeprg=go\ build\ ./...| set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab| set nolist
" Run go fmt on save
au FileType go au BufWritePre <buffer> Fmt
" Update ctags on save
au BufWritePost *.go silent! !/usr/local/bin/ctags -R &
" Build project
nmap <F3> :NERDTreeToggle<CR>
nmap <F6> :make<CR>:copen<CR>
" SuperTab knows when to trigger gocode or simple text completion, based on
" current context
let g:SuperTabDefaultCompletionType = "context"

" Markdown
" =========================================
au BufRead,BufNewFile *.md set filetype=markdown

" Close html tags with Leader+/
imap <silent> <C-c> </<C-X><C-O><C-X>

