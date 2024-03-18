filetype on
filetype plugin on 
filetype indent on

set foldmethod=indent

set spellfile=$HOME/.config/nvim/spell/es.utf-8.add
set spelllang=es,en
set spell

"Map <leader> key to comma
let mapleader = ','

set number          " Display line number
set relativenumber
syntax on

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set smarttab        " insert spaces or tabs to go to the next 
                    " indent of the next tabstop when the 
		    " cursor is at the beginning of a line

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tex setlocal ts=2 sts=2 sw=2 expandtab

set hlsearch
set incsearch

set scrolloff=8

call plug#begin()

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura'
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_latexmk_engines = {
            \'_'                    : '-xelatex',
            \}
let g:tex_indent_items = 0
let g:tex_indent_brace = 0
let g:tex_indent_and = 0

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

" setlocal spell
" set spelllang=es-MX
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

set rtp+=~/Documents/00-40EM-Electromagnetismo/Maestría

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
"################################################################
"#                                                              #
"# Text starts the code the netrw plugin                        #
"#                                                              # 
"################################################################

let g:netrw_altv = 1

"Map F5 to toggle on and off the line numbers in Normal mode
" nmap <F5> gh

" These next 2 lines will hide the dot files on startup
" let ghregex='\(^\|\s\s\)\zs\.\S\+'    
" let g:netrw_list_hide=ghregex        

"Map F6 to toggle on and off the baner
" nmap <F6> I

"#Turn off the banner at the top of the sreen on startup
" let g:netrw_banner=0    

"# to change the way netrw shows the files and directorys
"let g:netrw_liststyle= 0    " Default view (directory name/file name)
"let g:netrw_liststyle= 1    " Show time and size
"let g:netrw_liststyle= 2    " Shows listing in 2 columns
"
let g:netrw_liststyle= 3    " show the tree listing


"# Set the split windows to always be equal and open splits to the right
" let g:netrw_winsize = 0         "   set default window size to be always equal
let g:netrw_preview = 1		    "	open splits to the right

"#################################################################
"#                                                               #
"# End of text for video 33 - netrw pt3                          #
"#                                                               #
"#################################################################

Plug 'EdenEast/nightfox.nvim' " Color theme 
Plug 'arcticicestudio/nord-vim'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() 
            \: "\<C-g>u\<CR>"

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

let g:coc_filetype_map = {'tex' : 'latex'}

Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '▏'
let g:indentLine_setConceal = 0
" let g:indentLine_setColor = 0
" let g:indentLine_fgcolor_gui = '#bf616a'
" let g:indentLine_fgcolor_term = '#bf616a'
" let g:indentLine_color_term = '#bf616a'
" let g:indentLine_color_gui = '#bf616a'
" let g:indentLine_color_tty_light = '#bf616a'
" let g:indentLine_color_dark = '#bf616a'
" let g:indentLine_bgcolor_term = '#bf616a'
" let g:indentLine_bgcolor_gui = '#bf616a'

"local colors = {
  "  "#3b4252", "#bf616a", "#a3be8c", "#ebcb8b", "#81a1c1", "#b48ead", "#88c0d0", "#e5e9f0", "#465780", "#d06f79", "#b1d196", "#f0d399", "#8cafd2", "#c895bf", "#93ccdc", "#e7ecf4",
  "}

call plug#end()

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
inoremap <C-p> <CR><Esc>: silent exec '.!nori insert "'.b:vimtex.root.'/res/"'<CR><CR>:w<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

xnoremap <C-p> "_dP

