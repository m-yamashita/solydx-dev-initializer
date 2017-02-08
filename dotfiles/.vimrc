" .vimrc(ubuntu&win - 2013/07/31)

set t_Co=256
set runtimepath+=~/.vim

" dein.vim ------------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein.vim/repos/github.com/Shougo/dein.vim

call dein#begin('~/.vim/bundle')

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('mattn/emmet-vim')
call dein#add('othree/html5.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('honza/vim-snippets')
call dein#add('Shougo/neomru.vim')
call dein#add('KamunagiChiduru/vim-edit-properties')
call dein#add('szw/vim-tags')
call dein#add('scrooloose/syntastic')
call dein#add('tpope/vim-rails')
call dein#add('elzr/vim-json')
call dein#add('kchmck/vim-coffee-script')
call dein#add('thinca/vim-quickrun')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('ngmy/vim-rubocop')
call dein#add('vim-scripts/nginx.vim')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('ekalinin/Dockerfile.vim')
call dein#add('kannokanno/previm')
call dein#add('timcharper/textile.vim')
call dein#add('vim-scripts/fcitx.vim')
call dein#add( 'lambdalisue/vim-unified-diff')
call dein#add('vim-scripts/AnsiEsc.vim')
call dein#add('kshenoy/vim-signature')
call dein#add('jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}})
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('rking/ag.vim')

call dein#end()

filetype plugin indent on
syntax enable"
" end dein.vim ------------------------------------

" ctrlp.vim remapping
"nnoremap <c-l> :CtrlPMixed<CR>
let g:ctrlp_map = '<c-l>'
let g:ctrlp_use_migemo = 1
" let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数

" ag入ってたらptで検索させる
" ついでにキャッシュファイルからの検索もさせない
if executable('ag')
  let g:ctrlp_use_caching = 0
  " 「ag」の検索設定
  let g:ctrlp_user_command='ag %s -i --hidden -g ""'
endif

" ===== vim-unified-diff settings =====
"set diffexpr=unified_diff#diffexpr()
"
"" configure with the followings (default values are shown below)
"let unified_diff#executable = 'git'
"let unified_diff#arguments = [
"      \   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
"      \ ]
"let unified_diff#iwhite_arguments = [
"      \   '--ignore--all-space',
"      \ ]
" =====

" ===== AnsiEsc.vim settings =====
augroup quickrun
  autocmd!
  autocmd FileType quickrun AnsiEsc
augroup END
" =====
"
filetype indent on
filetype plugin on
colorscheme desert256

let g:previm_open_cmd = 'vivaldi'

" vim-table-mode
let g:table_mode_corner = "|"

" for unite-outline
let g:unite_data_directory = '~/.vimrc/unite-data'
let g:unite_abbr_highlight = 'normal'

" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
  endif

" Snippet directory
let g:neosnippet#snippets_directory = "~/.vim/.bundle/neosnippet-snippets, ~/.vim/original-snippet, ~/.vim/bundle/vim-snippets"

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_enable_javascript_checker = 1
let g:syntastic_javascript_checkers = ['eslint']

" vimshell
let g:vimshell_prompt = $USER."@vimshell: "
let g:vimshell_user_prompt = 'getcwd()'
let g:vimshell_execute_file_list = {}
let g:vimshell_execute_file_list["html"] = "firefox"
let g:vimshell_execute_file_list["xml"] = "firefox"
let g:vimshell_execute_file_list["js"] = "vim"
let g:vimshell_execute_file_list["css"] = "vim"
let g:vimshell_execute_file_list["txt"] = "vim"

" ファイルの漢字コード自動判別のために必要。(要iconv)
if has('iconv')
  set fileencodings&
  set fileencodings+=ucs-2le,ucs-2
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがJISX0213に対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  let &fileencodings = &fileencodings.','.s:enc_jis.',utf-8'
  if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    set fileencodings+=cp932
    let &encoding = s:enc_euc
  else
    let &fileencodings = &fileencodings.','.s:enc_euc
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

"vim-ref
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\ }
 
"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'
 
"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
 
" QuickRun
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'split': 'vertical',
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
let g:quickrun_config['ruby.bundle'] = { 'command': 'ruby', 'cmdopt': 'bundle exec', 'exec': '%o %c %s' }
nmap <Leader>r :QuickRun -runner vimproc<CR>
nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>

" ウィンドウ切り替えで閉じてしまう事故を防止
nmap <C-w>q <Esc>

let g:ref_refe_cmd = "~/.ruby-ref/ruby-ref/refe-1_8_7"

" JSLint実行エンジン
let $JS_CMD='rhino'

" 全角スペース・行末のスペース・タブの可視化
set list
if has("syntax")
    syntax on
    " PODバグ対策
    syn sync fromstart
    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
        "syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        "highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
        "syntax match InvisibleTab "\t" display containedin=ALL
        "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

" 検索用キーバインド
nmap n nzz
nmap N Nzz
nmap <C-n> <C-n>zz
nmap <C-p> <C-p>zz
nmap # #zz
nmap gg ggzz
nmap G Gzz
nmap u uzz
nmap <c-r> <c-r>zz
nmap <c-o> <c-o>zz
nmap <c-i> <c-i>zz
nmap gf gfzz
nmap gF gFzz
nmap <c-n> :cn<CR>
nmap <c-p> :cN<CR>
nmap * *zz
nmap { {zz
nmap } }zz
nmap g; g;zz
nmap g, g,zz


" JSON整形(要Python2.6以上)
map <Leader>j !python -m json.tool<CR>
" XML整形
map <Leader>x !python -m BeautifulSoup<CR>

" 行数表示
set nu
" 検索結果をループしない
set nowrapscan
" バックアップファイルを作成しない
set nobackup
" C-aの操作で8進数計算しないようにする。
set nf=""
" カーソル行のハイライト
set cursorline

" jslint.vim
"function! s:javascript_filetype_settings()
"  autocmd BufLeave     <buffer> call jslint#clear()
"  autocmd BufWritePost <buffer> call jslint#check()
"  autocmd CursorMoved  <buffer> call jslint#message()
"endfunction
"autocmd FileType javascript call s:javascript_filetype_settings()

set fenc=utf-8
set enc=utf-8
set fencs=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set ff=unix
set ffs=unix,dos

set sw=2
set tabstop=2
set expandtab
set softtabstop=2
set autoindent
set backspace=2
set hlsearch
set ambiwidth=double

if exists('&colorcolumn')
  set colorcolumn=+1
  autocmd FileType * setlocal textwidth=80
endif

" overflow color 52=#5f0000
highlight ColorColumn ctermbg=52

" カレントディレクトリに自動移動
" set autochdir

" スワップディレクトリ設定
set directory=~/.vim/swap
" バッファ切り替え時にもundo履歴を保持
set hidden
" 外部grep設定
set grepprg=grep\ -nHR\ --exclude-dir=.svn
" 左右分割時にデフォルトを右にする
set splitright

" TagList
" set tags=tags
" let g:tlist_javascript_settings = 'javascript;c:class;m:method;f:function;p:property;v:global variables'
nnoremap <C-]> g<C-]>

" VisualMode時にインクリメント/デクリメントを連続して行えるようにする
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

" 補完メニューの色
hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
hi PmenuSel ctermbg=blue ctermfg=black
hi PmenuSbar ctermbg=0 ctermfg=9
hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

" %によるペアリングの拡張
" (エラーが出た場合、`vim80`のバージョン部分を実際のディレクトリ名と合わせる)
source /usr/local/share/vim/vim80/macros/matchit.vim

" ===== Unite.vim =====
" history/yankの有効化
let g:unite_history_yank_enable=1
" ファイル履歴
nnoremap Ur :<C-u>Unite file_mru buffer<CR>
" ファイル
nnoremap Uf :<C-u>Unite file<CR>
" ヤンク/レジスタ履歴
nnoremap Uy :<C-u>Unite register history/yank<CR>

let g:vim_json_syntax_conceal = 0

augroup markdown
  autocmd!
  " .mdのファイルタイプをデフォルトでmarkdownに。
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  " インデント幅の調整
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set sw=4
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set tabstop=4
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set softtabstop=4
augroup END

augroup textile
  autocmd!
  " .textileのファイルタイプをデフォルトでtextileに。
  autocmd BufNewFile,BufRead *.{textile} set filetype=textile
  " インデント幅の調整
  autocmd BufNewFile,BufRead *.{textile} set sw=4
  autocmd BufNewFile,BufRead *.{textile} set tabstop=4
  autocmd BufNewFile,BufRead *.{textile} set softtabstop=4
augroup END

augroup cloudformation
  autocmd!
  " .templateのファイルタイプをデフォルトでjsonに。
  autocmd BufNewFile,BufRead *.{template} set filetype=json
augroup END


augroup nginx
  autocmd!
  autocmd BufNewFile,BufRead *nginx/*.conf set ft=nginx
augroup END

augroup ruby
  autocmd!
  " .rbのファイルタイプをRubyとして読む
  autocmd BufNewFile,BufRead *.{rb,god} set filetype=ruby
  " インデント幅の調整
  autocmd BufNewFile,BufRead *.{rb,god} set sw=2
  autocmd BufNewFile,BufRead *.{rb,god} set tabstop=2
  autocmd BufNewFile,BufRead *.{rb,god} set softtabstop=2
  " 保存時にRuboCopを自動でかける
  autocmd BufNewFile,BufWritePost *.{rb} RuboCop
augroup END

augroup javascript
  autocmd!
  " .js, .es6のファイルタイプをJavaScriptとして読む
  autocmd BufNewFile,BufRead *.{js,es6} set filetype=javascript
  " インデント幅の調整
  autocmd BufNewFile,BufRead *.{js,es6} set sw=2
  autocmd BufNewFile,BufRead *.{js,es6} set tabstop=2
  autocmd BufNewFile,BufRead *.{js,es6} set softtabstop=2
augroup END

augroup Jenkinsfile
  autocmd!
  " JenkinsfileをGroovyとして読む
  autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
  " インデント幅の調整
  autocmd BufNewFile,BufRead *.{js,es6} set sw=2
  autocmd BufNewFile,BufRead *.{js,es6} set tabstop=2
  autocmd BufNewFile,BufRead *.{js,es6} set softtabstop=2
augroup END

" vim-railsでServiceを移動対象に含める
let g:rails_projections = {
  \ "app/services/*.rb": {
  \   "command": "service",
  \   "test": "spec/services/%s_spec.rb"
  \ }
  \ }

" 自動改行しない
set formatoptions=q

" gfコマンドの拡張
nmap gl :vertical wincmd f<CR>
nmap gk :wincmd f<CR>

" 環境依存用 .vimrc 読み込み
source ~/.vimrc_local

" smart indent when entering insert mode with i on empty lines
" Insertモード時の自動インデント
function! IndentWithI()
    if len(getline('.')) == 0
        return "cc"
    else
        return "i"
    endif
endfunction
function! IndentWithA()
    if len(getline('.')) == 0
        return "cc"
    else
        return "a"
    endif
endfunction
nnoremap <expr> i IndentWithI()
nnoremap <expr> a IndentWithA()

" Reload .vimrc and .gvimrc
if exists(':ReloadRc') == 2
  delcommand ReloadRc
endif
command ReloadRc :source ~/.vimrc | :source ~/.gvimrc

" Rename file.
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
