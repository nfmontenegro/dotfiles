call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gruvbox-community/gruvbox'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'vim-test/vim-test'
Plug 'blackcauldron7/surround.nvim'
Plug 'tpope/vim-surround'
Plug 'psliwka/vim-smoothie'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'ghifarit53/tokyonight-vim'
Plug 'dense-analysis/ale'
Plug 'windwp/nvim-autopairs'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'norcalli/nvim-colorizer.lua'

" LSPConfig
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" For vsnip user.
Plug 'hrsh7th/vim-vsnip'


" telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Initialize plugin system
call plug#end()
lua require("lsp-config")

nmap <C-n> :NERDTreeToggle<CR>

let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeColorMapCustom = {
   \ "Staged"    : "#0ee375",
   \ "Modified"  : "#d9bf91",
   \ "Renamed"   : "#51C9FC",
   \ "Untracked" : "#FCE77C",
   \ "Unmerged"  : "#FC51E6",
   \ "Dirty"     : "#FFBD61",
   \ "Clean"     : "#87939A",
   \ "Ignored"   : "#808080"
   \ }

let g:NERDTreeIgnore = ['^node_modules$']

" buffers
map gn :bn<cr>
map gp :bp<cr>
map gk :bd<cr>

" disable recording
map q <Nop>

set guicursor=

set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent
set cindent
set nu
set nowrap
set noswapfile
set nobackup
set termguicolors
set scrolloff=8
set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0
set completeopt=menuone,noselect
set list
set showbreak=↪\
set listchars=tab:→\ ,eol:¬,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Give more space for displaying messages.
set cmdheight=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Gruvbox theme
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection='0'
let g:airline_theme='gruvbox'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%;lum]"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%;lum]"
endif

" Tokyonight theme
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_cursor='blue'
let g:tokyonight_menu_selection_background='blue'
let g:tokyonight_enable_italic=1

colorscheme gruvbuddy

" Find files using Telescope command-line sugar.
nmap <C-p> :Telescope find_files<CR>
nmap <C-g> :Telescope live_grep<CR>
nmap <C-y> :Telescope buffers<CR>
nmap <C-o> :Telescope help_tags<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <CR> InsertMapForEnter()
function! InsertMapForEnter()
    if pumvisible()
        return "\<C-y>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction


" Airline config
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" vim tests
let test#strategy = 'neovim'
let g:test#neovim#start_normal = 1 " If using neovim strategy
let g:test#basic#start_normal = 1 " If using basic strategy

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nmap <c-m> :MaximizerToggle<cr>

" linter
let b:ale_fixers = ['prettier', 'eslint']

" lspconfig compe
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'always'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
