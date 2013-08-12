" run pathogen as the first line of the file
call pathogen#infect()

set rtp+=~/.vim/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-vividchalk'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Gist.vim'
Bundle 'slim-template/vim-slim'
" Bundle 'yamlvim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'h1mesuke/unite-outline'
Bundle 'mattn/zencoding-vim'
Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'scrooloose/nerdtree'
Bundle 'buftabs'
Bundle 'TwitVim'
Bundle 'pasela/unite-webcolorname'
Bundle 'kana/vim-operator-replace'
Bundle 'lilydjwg/colorizer'

" 文字コードの設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" 検索文字のハイライト
set hlsearch
" 検索時、大文字小文字無視
set ignorecase
" 検索時、大文字から始めたら大文字小文字を無視しない
set smartcase
" ファイル形式の検出
filetype on
" ファイル形式別のインデントを有効にする
" ファイル形式別のプラグインを有効にする
filetype plugin indent on

" エラーベルを鳴らさない
set noerrorbells

" バックアップファイルを作らない
set nobackup

" バッファを切り替えてもundoの効果を失わないようにする
set hidden
" 行数を表示する
set number
" ステータスバーを下から2行目に表示
set laststatus=2
" カーソル位置を表示する
set ruler
" カーソルのある行に下線を引く
set cursorline

" 自動インデントを有効にする
set autoindent

syntax on

" vividchalk as colorscheme
colorscheme vividchalk

"" Ruby, Ruby on Rails, Sinatraなどの開発用オプション
" 通常、tabはスペース4つ分
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2
" erb/html/yml/rbの場合はスペース2つ分
au BufNewFile,BufRead *.html.erb set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.css. set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.html set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.haml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.slim set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.js set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.js.coffee set tabstop=2 shiftwidth=2 expandtab
" RailsはUTF-8で書く　
au User Rails* set fenc=utf-8
let ruby_space_errors=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1
let g:rails_level=4
let g:rails_syntax=1
let g:rails_default_database='sqlite3'

"バッファタブにパスを省略してファイル名のみ表示する(buftabs.vim)
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1

"neocomplcache周りの設定
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_syntax_length=3
" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" map, nmap
" 保存とか
nmap <Space>w :up<CR>
nmap <Space>q :q<CR>
nmap <Space>z <C-z>

" Space + hl で:nohl
nmap <Space>hl :nohl<CR>

" ノーマルモードでもエンターキーで改行を挿入
noremap <CR> o<ESC>

" バッファの移動を矢印キーで
map <LEFT> <ESC>:bp<CR>
map <RIGHT> <ESC>:bn<CR>
map <UP> <ESC>:ls<CR>
map <Space>d <ESC>:bd<CR>

" :と数字でバッファ移動
map <ESC>:1 <ESC>:b1

" CTRL-Spaceでomni補完
imap <C-Space> <C-x><C-o>

"CTRL-kでクリップボードから貼り付け
imap <C-k> <ESC>"+gpa

"edit routes & schema

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb
command! Rapp :e config/application.rb
command! Rinitializer :e config/initializers/

function! MagicComment()
  return "# coding: utf-8\<CR>"
endfunction

inoreabbrev <buffer> #### <C-R>=MagicComment()<CR>

" Space + . でvimrcを開く
nnoremap <Space>. :<C-u>edit ~/.vimrc<Enter>

" Vimテクニックバイブルのお試し系

" Insertのときにstatuslineの色を変える
au InsertEnter * hi StatusLine guifg=Black guibg=Yellow gui=none ctermfg=Black ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=White guibg=DarkGray gui=none ctermfg=White ctermbg=DarkGray cterm=none

set listchars=eol:$,tab:>\

autocmd FileType ruby map <F9> :w<CR>:!ruby -c %<CR>

function! s:SetupSpeCuke()
	command! RunTestFile exe '!sc ' . expand('%:p')
	command! RunTestCase exe '!sc --line ' . line('.') . ' ' . expand('%:p')

	nnoremap -tf :RunTestFile<CR>
	nnoremap -tc :RunTestCase<CR>
endfunction

au BufRead,BufNewFile *_spec.rb,*.feature call s:SetupSpeCuke()

" 文字コード
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8

" □とか○の文字があってもカーソル位置がずれないようにする
 if exists('&ambiwidth')
   set ambiwidth=double
   endif

" 改行コード
set fileformats=unix,dos,mac

" 開いているディレクトリに移動
command! -nargs=0 CD :execute 'lcd ' . expand("%:p:h")

" 括弧入力後に←に移動
" imap {} {}<Left>
map {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>

" ;でコマンド入力( ;と:を入れ替)
noremap ; :

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" swpファイルつくらない
set noswapfile

" クリップボードを有効に
set clipboard=unnamed,autoselect

" space + . で .vimrc開く
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" コピーした文字で上書きペースト
vnoremap <silent> <C-p> "0p<CR>

" :e でカレントディレクトリファイル開く
map :e :e<Space><C-x>

" :e でカレントウィンドウのみカーソルラインを有効に
  augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter,BufRead * set cursorline cursorcolumn
  augroup END
