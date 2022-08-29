call plug#begin('~/.config/nvim/plugged')

"style
Plug 'savq/melange'

"ide support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive' " git

"Snippets
Plug 'honza/vim-snippets'

"language specific
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'lervag/vimtex'

"misc
Plug 'fladson/vim-kitty' "kitty config file highlighting
Plug 'frenzyexists/aquarium-vim', { 'branch': 'develop' }

call plug#end()


set splitbelow
set splitright

let g:airline#extensions#tabline#enabled = 1
 


set encoding=utf-8
set nu

"colors
set termguicolors

colorscheme aquarium
let g:aquarium_style="dark"
let g:airline_theme="base16_aquarium_dark"
let g:aqua_bold = 1
let g:aqua_transparency = 1
" Enable folding with spacebar

set foldmethod=indent
set foldlevel=99
nnoremap <space> za
let g:SimpylFold_docstring_preview=1


"handle arduino shit 
au BufRead,BufNewFile *.ino, *.pde set filetype=c++

"syntax stuff
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=red guibg=red
let python_highlight_all=1
syntax on

""" alt remap to move around splits
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

":term bindings
"map alt-esc to escape terminal
:tnoremap <A-Esc> <C-\><C-n>


"""""""""""""""""""""
"""""""""""""""""""""
" Language Specific "
"""""""""""""""""""""
"""""""""""""""""""""

"latex
let g:vimtex_enabled = 1
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" haskell
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>hk :call LanguageClient#textDocument_hover()<CR>
map <Leader>hg :call LanguageClient#textDocument_definition()<CR>
map <Leader>hr :call LanguageClient#textDocument_rename()<CR>
map <Leader>hf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>hb :call LanguageClient#textDocument_references()<CR>
map <Leader>ha :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>hs :call LanguageClient#textDocument_documentSymbol()<CR>

" indentation

au BufNewFile,BufRead *.py, *.sable
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=89 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.c, *.cpp, *.h
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=89 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

""""""""""""""""""""""""""""""""""
" COC """"""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = ['coc-html', 'coc-pyright', 'coc-java', 'coc-json', 'coc-explorer', 'coc-snippets', 'coc-tsserver', 'coc-clangd']

nnoremap <space>e :CocCommand explorer<CR>

set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c


""Map <tab> for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#_select_confirm() :
\ coc#expandableOrJumpable() ?
\ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
""

"""Snippets
"""

inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(1) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(1) : "\<up>"

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

""" Other Stuff

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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Show syntax highlighting groups for word under cursor
nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")') 
endfunc

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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

" jupyter support
" Jupytext
let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'
nmap ]x ctrih/^# %%<CR><CR>
