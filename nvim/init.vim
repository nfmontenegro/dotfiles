call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'gruvbox-community/gruvbox'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'vim-test/vim-test'
Plug 'blackcauldron7/surround.nvim'
Plug 'tpope/vim-surround'
Plug 'psliwka/vim-smoothie'
Plug 'puremourning/vimspector'
Plug 'dense-analysis/ale'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'norcalli/nvim-colorizer.lua'

" LSP config
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
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
set splitright
set signcolumn=yes
set cursorline
set isfname+=@-@
" set ls=0
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
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%;lum]"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%;lum]"
endif


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

" vim tests
let test#strategy = 'neovim'
let g:test#neoim#start_normal = 1 " If using neovim strategy
let g:test#basic#start_normal = 1 " If using basic strategy

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" linter
let b:ale_fixers = ['prettier', 'eslint']

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>