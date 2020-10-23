set nocompatible              " be iMproved, required

syntax on
set number
set relativenumber
set laststatus=2

set expandtab
set ts=4 sw=4
set shiftwidth=4
set smartindent
set autoindent
" set foldmethod=syntax

set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase

set undodir=~/.vim/undodir
set undofile

set nowrap
set noerrorbells
set cursorline
set scrolloff=8
set cmdheight=1
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

filetype off                  " required


" LITTLE HELP
" git repos on your local machine
" Plugin 'file:///home/gmarik/path/to/plugin'
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()     " alternative: pass a path
Plugin 'VundleVim/Vundle.vim'

" Autocompletes
" Plugin 'Valloric/YouCompleteMe'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
" Plugin 'ajh17/VimCompletesMe'

" Themes & Colorscheme
Plugin 'vim-airline/vim-airline'                        " status line & other chunks
Plugin 'vim-airline/vim-airline-themes'                 " exotic themes
Plugin 'nanotech/jellybeans.vim'                        " beautiful vim theme
" Plugin 'Gruvbox-community/gruvbox'                      " gruvbox
Plugin 'shmup/vim-sql-syntax'                           " sql syntax highlight

" Utilitarian
" Pass the path to set the runtimepath properly.
Plugin 'scrooloose/nerdcommenter'                       " 
Plugin 'scrooloose/nerdtree'                            " a tree explorer
Plugin 'mbbill/undotree'
Plugin 'rking/ag.vim'                                   " text search
Plugin 'junegunn/fzf', {'do': { -> fzf#install()}}      " better file search
Plugin 'junegunn/fzf.vim'
" Plugin 'kien/ctrlp.vim'                                 " file search

" TODO: understand the following
Plugin 'tpope/vim-surround'                             " surrounding toy
Plugin 'tpope/vim-fugitive'                             " vim git cmd
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}              " HTML/ CSS-like snippet tool?
Plugin 'git://git.wincent.com/command-t.git'            " fast file navigation for VIM

" Gaming now
Plugin 'ThePrimeagen/vim-be-good'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


let vim_markdown_preview_github=1
let b:vcm_tab_complete=1

colorscheme jellybeans
set background=dark
let g:jellybeans_overrides = {'background': { 'guibg': '121212' }}

let g:jellybeans_use_term_italics = 1
let g:airline_extensions = []
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_invert_selection='0'

" Nerd Commenter Settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
let g:NERDTrimTrailingWhitespace = 1

" FZF
let g:fzf_layout = {'window': {'width':0.7, 'height':0.8}}
let $FZF_DEFAULT_OPTS='--reverse'

" ycm
" let g:ycm_keep_logfiles = 1
" let g:ycm_log_level = 'debug'

" rtp
let &rtp .= ',' . expand('<sfile>p:h')
filetype plugin indent on



" REMAP
let mapleader = " "

" split sizing
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>_ :resize -5<CR>

" split navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader><Left> :wincmd h<CR>
nnoremap <leader><Down> :wincmd j<CR>
nnoremap <leader><Up> :wincmd k<CR>
nnoremap <leader><Right> :wincmd l<CR>

" copy paste
noremap <leader>y "*y   " prime selection 
noremap <leader>p "*p   " prime selection
noremap <C-Y> "+y   " system clipboard register
noremap <C-l> "+p   " system clipboard register

" lazy shortcuts
nnoremap <leader>n :noh<CR>
nnoremap <leader>o :browse oldfiles<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 35<CR>
nnoremap <leader>d :NERDTree<CR> :vertical resize 30<CR>


let g:highlighting = 0
function! Highlighting()
    if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
        let g:highlighting = 0
        return ":silent nohlsearch\<CR>"
    endif
    let @/ = '\<'.expand('<cword>').'\>'
    let g:highlighting = 1
    return ":silent set hlsearch\<CR>"
endfunction

nnoremap <silent> <expr> <CR> Highlighting()

" Highlight TODO, FIXME, NOTE, etc.
if has('autocmd') && v:version > 701
    augroup todo
        autocmd!
        autocmd Syntax * call matchadd(
                    \ 'Debug',
                    \ '\v\W\zs<(NOTE|INFO|IDEA|TODO|FIXME|CHANGED|XXX|BUG|HACK|TRICKY)>'
                    \ )
    augroup END
endif



"" COC.nvim example configuration

"" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <C-A>  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <C-E>  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <C-C>  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <C-O>  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <C-S>  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <C-J>  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <C-K>  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <C-P>  :<C-u>CocListResume<CR> endif
