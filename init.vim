set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
filetype indent on      " load filetype-specific indent files

" for tabulation
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
:set cursorline

"inoremap jk <esc>

call plug#begin('~/.vim/plugged')


"PlatformIO
Plug 'normen/vim-pio'
Plug 'coddingtonbear/neomake-platformio'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'

Plug 'tmsvg/pear-tree'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'

Plug 'vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" color schemas
Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'
Plug 'shaunsingh/nord.nvim'
Plug 'morhetz/gruvbox'  " colorscheme gruvbox
Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'

Plug 'xiyaowong/nvim-transparent'

Plug 'Pocco81/auto-save.nvim'
Plug 'justinmk/vim-sneak'

" JS/JSX/TS
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
" TS from here https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-lua/plenary.nvim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'bmatcuk/stylelint-lsp'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Convenient floating terminal window
"Plug 'voldikss/vim-floaterm'

call plug#end()




" General settings____________________________________________________________

let mapleader = ' '

" Running python scripts inside  nvim window__________________________________

autocmd FileType python map <buffer> <C-h> :w<CR>:exec '!python3.11' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-h> <esc>:w<CR>:exec '!python3.11' shellescape(@%, 1)<CR>

" Running C++ scripts inside nvim window
autocmd FileType cpp map <buffer> <C-h> :w<CR>:exec '!g++' shellescape(@%, 1) '-o out; ./out'<CR>
autocmd FileType cpp imap <buffer> <C-h> <esc>:w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>


"Styling______________________________________________________________________

"colorscheme nord
"colorscheme OceanicNext
"colorscheme gruvbox
"colorscheme codedark


"Setup VS colorscheme
let g:codedark_conservative=0 " Style of the standard Visual Studio
let g:codedark_transparent=0 " Make the background transparent
let g:codedark_italics=0 " Make the background transparent
let g:airline_theme = 'codedark' " If you have vim-airline, you can also enable the provided theme

" Setup gruvbox colorscheme
"let g:airline_theme='gruvbox'

"Actual colorscheme
colorscheme codedark

if $TERM_PROGRAM =~ "iTerm"
  let g:airline_powerline_fonts = 1 " Enable only with PowerLine Font
endif

"_____________________________________________________________________________



"comments
nmap <C-_> <plug>nerdcommentertoggle
nmap <C-_> <plug>nerdcommentertoggle<CR>gv

"files tree
let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
nmap <F2> :NERDTreeToggle<CR>

"folder
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
nmap <leader>, :bp<CR>
nmap <leader>. :bn<CR>
nmap <C-w> :bd<CR>


"search
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>


set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<esc>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      ['<S-CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items. #default = '<CR>'
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup { 
    capabilities = capabilities
  }
  "require('lspconfig')['clangd'].setup { 
  "  --capabilities = capabilities
  "  on_attach = on_attach, 
  "  flags = lsp_flags
  "}
  "
  require('lspconfig')['ccls'].setup { 
    --capabilities = capabilities
    on_attach = on_attach, 
    flags = lsp_flags
  }
EOF



"require('lspconfig')['pyright'].setup {
