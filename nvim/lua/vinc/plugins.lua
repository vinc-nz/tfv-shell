

vim.cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself
paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/completion-nvim'}
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}
paq {'907th/vim-auto-save'}
paq { 'SirVer/ultisnips' }
paq { 'honza/vim-snippets' }
paq { 'mhinz/vim-startify' }
paq { 'mhinz/vim-signify' }
paq { 'famiu/feline.nvim' }
paq { 'hoob3rt/lualine.nvim' }
paq { 'ryanoasis/vim-devicons' }
paq { 'nvim-lua/lsp-status.nvim' }
paq { 'preservim/tagbar' }
paq { 'wincent/vim-clipper' }
paq {'rhysd/vim-clang-format'}
paq { 'famiu/nvim-reload' }
paq { 'crispgm/nvim-tabline' }
paq { 'phleet/vim-mercenary' }
