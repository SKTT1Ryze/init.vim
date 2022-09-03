" coc.nvim required:
"   1. node.js
"   2. yarn
"
" ++++++++++++++++++++++
" +++ Enhance Editor +++
" ++++++++++++++++++++++
set number
set relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ignorecase
set smartcase
set notimeout
set jumpoptions=stack
set fdm=marker
set foldmarker=//{,//}
set background=dark

" +++++++++++++++
" +++ Key Map +++
" +++++++++++++++
"
" set leader key
let mapleader="\<SPACE>"

" CTRL + z to undo
noremap <silent> <C-z> u

" CTRL + s to save
noremap <silent> <C-s> :w<CR>

" Visual mode <LEADER> - y to copy
vnoremap <LEADER>y "+y

" Normal mode <LEADER> - p to paste
nnoremap <LEADER>p "+p

" Normal mode <LEADER> - [ to flod
nnoremap <LEADER>[ zfa{

" Normal mode <LEADER> - ] to unflod
nnoremap <LEADER>] zo

" Display matches for a search pattern while you type.
set incsearch

" download vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  :exe '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" +++++++++++++++++++++
" +++ plugins begin +++
" +++++++++++++++++++++
call plug#begin('~/.config/nvim/plugged')
  " comment
  Plug 'tomtom/tcomment_vim'
  
  " file explorer
  Plug 'preservim/nerdtree'
  
  " file finder
  Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " theme
  Plug 'itchyny/lightline.vim'
  Plug 'yuttie/inkstained-vim'
  Plug 'sainnhe/everforest'
  Plug 'sainnhe/gruvbox-material'
  Plug 'arcticicestudio/nord-vim'

  " lsp
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " highlight
  Plug 'jackguo380/vim-lsp-cxx-highlight'

  " debug
  Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-rust'}
call plug#end()

" +++ tomtom/tcomment_vim +++
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<

" +++ preservim/nerdtree
nnoremap <LEADER>e :NERDTreeToggle<CR>
nnoremap <LEADER>t :NERDTreeFind<CR>

" +++ Yggdroot/LeaderF +++
let g:Lf_WindowPosition='popup'
let g:Lf_PreviewInPopup=1
let g:Lf_CommandMap = {
\   '<C-p>': ['<C-k>'],
\   '<C-k>': ['<C-p>'],
\   '<C-j>': ['<C-n>']
\}
nmap <leader>f :Leaderf file<CR>
nmap <silent> <C-f> :Leaderf file<CR>
nmap <leader>b :Leaderf! buffer<CR>
nmap <leader>F :Leaderf rg
let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"

" ===== colorscheme =====

" +++ yuttie/inkstained-vim +++
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator':    { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ }

" colorscheme inkstained

" colorscheme everforest

colorscheme nord

" +++ jackguo380/vim-lsp-cxx-highlight +++
hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymClass cxxTypeAlias

" +++ neoclide/coc.nvim +++
" coc extensions
let g:coc_global_extensions = [
    \ 'coc-highlight',
    \ 'coc-rust-analyzer',
    \ 'coc-vimlsp',
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-sumneko-lua'
    \ ]

set signcolumn=number

" <TAB> to select candidate forward or
" pump completion candidate
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
" <s-TAB> to select candidate backward
inoremap <expr><s-TAB> pumvisible() ? "\<S-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.')-1
  return !col || getline('.')[col-1] =~# '\s'
endfunction
" <CR> to comfirm selected candidate
" only when there's selected completed item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" open help document
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpr#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight link CocHighlightText Visual
" autocmd CursorHold * silent call CocActionAsync('highlight') " TODO

" global rename (dangerous!)
nmap <LEADER>rn <Plug>(coc-rename)

" format
" xmap <LEADER>f <Plug>(coc-format-selected)
" command! -nargs=0 Format :call CocActions('format')

" diagnostic info
nnoremap <silent><nowait><LEADER>d :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <LEADER>qf <Plug>(coc-fix-current)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Go back
nmap <silent> gb <C-o>

" +++ puremourning/vimspector +++
let g:vimspector_enable_mappings = 'HUMAN'

" +++ neovide +++
let g:neovide_transparency=0.8
