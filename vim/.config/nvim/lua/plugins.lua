return require('packer').startup(function(use)
  use({'wbthomason/packer.nvim'})
  use({'hkupty/iron.nvim', config = [[require('config.iron')]] })
  use({'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}})
  use({'neovim/nvim-lspconfig'})
  use({'nvim-lua/completion-nvim'})
  -- TODO: replace with folke/which-key.nvim
  use({'AckslD/nvim-whichkey-setup.lua', requires = {'liuchengxu/vim-which-key'}})
  use({'norcalli/nvim-colorizer.lua'})
  use({'windwp/nvim-autopairs'})
  use({'tpope/vim-commentary'})
  use({'JoosepAlviste/nvim-ts-context-commentstring'})
  -- use({'editorconfig/editorconfig-vim'})
  use({'qpkorr/vim-bufkill'})
  use({'drewtempelmeyer/palenight.vim'})
  use({'glepnir/galaxyline.nvim', branch = 'main' })
  use({'nvim-treesitter/nvim-treesitter',
    ensure_installed = 'maintained',
    run = {':TSUpdate'},
    branch = 'master'})
  use({'romgrk/nvim-treesitter-context'})
  use({'mhinz/vim-startify'})
  use({'tpope/vim-surround'})
  use({'mbbill/undotree', config = [[vim.g.undotree_SetFocusWhenToggle = 1]]})
  use({'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  })
  use({'kyazdani42/nvim-tree.lua'})
  use({'tpope/vim-repeat'})
  use({'norcalli/snippets.nvim'})
  use({'kmonad/kmonad-vim'})
end)
