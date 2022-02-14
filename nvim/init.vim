call plug#begin('~/.vim/plugged')

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'vim-test/vim-test'
Plug 'blackcauldron7/surround.nvim'
Plug 'tpope/vim-surround'
Plug 'puremourning/vimspector'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'pantharshit00/vim-prisma'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'ThePrimeagen/harpoon'

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

" key leader
let mapleader=","

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
"set cursorline
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
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection='0'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%;lum]"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%;lum]"
endif

" vim tests
let test#strategy = 'neovim'
let g:test#neovim#start_normal = 1 " If using neovim strategy
let g:test#basic#start_normal = 1 " If using basic strategy

let g:indent_blankline_disable_with_nolist = v:true
let g:indent_blankline_enabled = v:false

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

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>

" nvim tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

" vimspector
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

" Harpoon
nnoremap <Leader>hh :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <Leader>hj :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>hy :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <Leader>hu :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <Leader>hi :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <Leader>ho :lua require("harpoon.ui").nav_file(4)<CR>

" resize
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
