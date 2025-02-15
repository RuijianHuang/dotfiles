set nocompatible              " use Vim defaults instead of Vi defaults

" appearances
syntax enable
set number
set relativenumber
set nowrap
set cursorline
set ruler
set showtabline=2             " always show buffer tabs
set noshowmode                " no --INSERT-- down below
set cmdheight=1
set laststatus=0
set termguicolors
set background=dark
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" whitespaces
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent

" searching
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase

" preferences
set mouse=a
set noerrorbells
set shortmess+=c
set undodir=~/.vim/undodir      " cross section undo
set undofile
set scrolloff=8                 " min #lines above/below current screen"
set foldcolumn=0
" set foldmethod=syntax
" set clipboard=unnamedplus       " copy/paste with everything else

" nerd
set hidden
set nobackup                    " recommended by coc
set nowritebackup               " recommended by coc
set splitbelow
set splitright
set iskeyword+=-                " treat dash-word as a word object
set t_Co=256
set encoding=utf-8
set updatetime=300
filetype off                    " native-vim filetype detection; need to be off for vundle




" here goes plugins
let $MYVIMRC='$HOME/.vimrc'     " TODO: change vimdir, .vimrc path?

set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()     " alternative: pass a path
Plugin 'VundleVim/Vundle.vim'

" Autocompletes
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
" Plugin 'ajh17/VimCompletesMe'

" Colorscheme & syntax
Plugin 'nanotech/jellybeans.vim'                        " beautiful vim theme
Plugin 'joshdick/onedark.vim'
Plugin 'vim-airline/vim-airline'                        " status line & other chunks
Plugin 'vim-airline/vim-airline-themes'                 " exotic themes
Plugin 'shmup/vim-sql-syntax'                           " sql syntax highlight
Plugin 'sheerun/vim-polyglot'                           " syntax highlight for py?
" Plugin 'flazz/vim-colorschemes'                         " collection of colorschemes
" Plugin 'Gruvbox-community/gruvbox'                      " gruvbox

" Utilitarian
Plugin 'scrooloose/nerdcommenter'                       " comment with style
Plugin 'scrooloose/nerdtree'                            " a tree explorer
Plugin 'mbbill/undotree'
Plugin 'rking/ag.vim'                                   " text search
Plugin 'junegunn/fzf', {'do': { -> fzf#install()}}      " fuzzy find
Plugin 'junegunn/fzf.vim'                               " fuzzy find
Plugin 'jiangmiao/auto-pairs'                           " close ()[]{} for me
" Plugin 'yuttie/comfortable-motion.vim'                  " scrolling feels
" Plugin 'ThePrimeagen/vim-be-good'

" new puppies
Plugin 'iamcco/markdown-preview.nvim'                    " preview in browser
Plugin 'voldikss/vim-floaterm'
Plugin 'tpope/vim-surround'                             " change surrounds e.g.: ysiw[  ds'  cs[(
Plugin 'tpope/vim-fugitive'                             " vim git cmd
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}              " HTML/ CSS-like snippet tool?
Plugin 'git://git.wincent.com/command-t.git'            " fast file navigation for VIM
Plugin 'wesQ3/vim-windowswap'                           " swap split panes by marking then swapping

" new js, react helpers
" Plugin 'styled-components/vim-styled-components', {'branch': 'main'}
" Plugin 'jparise/vim-graphql'
" Plugin 'pangloss/vim-javascript'
" Plugin 'leafgarland/typescript-vim'


call vundle#end()            " required
filetype plugin indent on    " required


" colorscheme settings
colorscheme jellybeans

" checks if terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" autocmd vimenter * hi Comment cterm=italic term=italic    " FIXME: not italic on startup
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

" override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    " autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
    " autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
  augroup END
endif

" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_invert_selection=0

let g:jellybeans_overrides = {'background': { 'guibg': '121212' }}
let g:jellybeans_use_term_italics=1

" airline
" let g:airline_extensions = []
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 2
let g:airline#extensions#tabline#show_tabs = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'minimalist'

" Nerd Commenter Settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
let g:NERDTrimTrailingWhitespace = 1


" FZF
let g:fzf_layout = {'window': {'width':0.8, 'height':0.8}}
let $FZF_DEFAULT_OPTS='--reverse'

" windowsawp
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>


" rtp
let &rtp .= ',' . expand('<sfile>p:h')
filetype plugin indent on

" coc-explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" coc with node
" if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
"   let g:coc_global_extensions += ['coc-prettier']
" endif

" if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"   let g:coc_global_extensions += ['coc-eslint']
" endif

















" REMAP
let mapleader = "\<Space>"

" split sizing
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>_ :resize -5<CR>
nnoremap <C-j> :resize -5<CR>                   " more resizing
nnoremap <C-k> :resize +5<CR>
nnoremap <C-h> :vertical resize -5<CR>
nnoremap <C-l> :vertical resize +5<CR>
nnoremap <C-Down> :resize -3<CR>
nnoremap <C-Up> :resize +3<CR>
nnoremap <C-Left> :vertical resize -3<CR>
nnoremap <C-Right> :vertical resize +3<CR>


" split navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader><Left> :wincmd h<CR>
nnoremap <leader><Down> :wincmd j<CR>
nnoremap <leader><Up> :wincmd k<CR>
nnoremap <leader><Right> :wincmd l<CR>

" split rotation
nnoremap <leader>rv <C-w>t<C-w>K
nnoremap <leader>rh <C-w>t<C-w>H


" tabs navigation
nnoremap <C-n> :bn<CR>

" copy paste
noremap <leader>y "*y   " prime selection 
noremap <leader>p "*p   " prime selection
noremap <C-Y> "+y       " system clipboard register
noremap <C-l> "+p       " system clipboard register

" folding
" nmap <silent> FF :foldclose<CR>
" nmap <silent> ff :foldopen<CR>

" rigidity
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" lazyness
nnoremap <leader>so :source ~/.vimrc<CR>
nnoremap <leader>n  :noh<CR>
nnoremap <leader>u  :set relativenumber!<CR>
nnoremap <leader>o  :browse oldfiles<CR>
nnoremap <leader>z  :FZF<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fb :Buffer<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fc :Blines<CR>
nnoremap <leader>tn :FloatermNew<CR>
nnoremap <leader>ut :UndotreeShow<CR>
nnoremap <leader>d  :NERDTree<CR> :vertical resize 30<CR>
nnoremap <leader>e  :CocCommand explorer<CR>
nnoremap <leader>co 1z=
nnoremap <leader>sp :set spell!<CR>
nnoremap <leader>wr :set wrap!<CR>


" (no)hlsearch by pressing enter
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
" nnoremap <silent> <expr> <CR> Highlighting()

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



" COC.nvim example configuration

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

" Add (Neo)Vim's native statusline support. FIXME: airline conflict
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
nnoremap <silent><nowait> <C-P>  :<C-u>CocListResume<CR>
