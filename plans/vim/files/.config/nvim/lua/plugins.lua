return require('packer').startup(function(use)
  use({'wbthomason/packer.nvim'})
  use({'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}})
  use({'neovim/nvim-lspconfig'})
  use({'hrsh7th/nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lsp'})
  use({'hrsh7th/cmp-buffer'})
  use({'hrsh7th/cmp-path'})
  use({'hrsh7th/cmp-cmdline'})
  use({'folke/which-key.nvim'})
  use({'norcalli/nvim-colorizer.lua'})
  use({'numToStr/Comment.nvim', config = function() require('Comment').setup() end })
  use({'JoosepAlviste/nvim-ts-context-commentstring'})
  use({'ojroques/nvim-bufdel'})
  use({'vikdotdev/bufnav.nvim'})
  use({'projekt0n/github-nvim-theme'})
  -- use 'folke/tokyonight.nvim'
  use({'nvim-treesitter/nvim-treesitter',
    ensure_installed = 'all',
    run = {':TSUpdate'},
    branch = 'master',
  })
  use({'romgrk/nvim-treesitter-context'})
  use({'mhinz/vim-startify'})
  use({'tpope/vim-surround'})
  use({'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }})
  use({'kyazdani42/nvim-tree.lua'})
  use({'L3MON4D3/LuaSnip'})
  use({'kmonad/kmonad-vim'})
  use({'deris/vim-shot-f'})
  use({'mickael-menu/zk-nvim'})
end)

