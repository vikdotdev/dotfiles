return require('packer').startup(function(use)
  -- Packer can manage itself
  use({'wbthomason/packer.nvim'})
  -- use({'TimUntersberger/neogit'})
  use({ 'hkupty/iron.nvim', config = [[require('config.iron')]] })
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  })
  use({'neovim/nvim-lspconfig'})
  use({'nvim-lua/completion-nvim'})
  use({'AckslD/nvim-whichkey-setup.lua', requires = {'liuchengxu/vim-which-key'}})
  use({'norcalli/nvim-colorizer.lua'})
  use({'diepm/vim-rest-console'})
  use({'windwp/nvim-autopairs'})
  use({'tpope/vim-commentary'})
  -- use({'preservim/nerdtree'})
  use({'editorconfig/editorconfig-vim'})
  use({'qpkorr/vim-bufkill'})
  use({'drewtempelmeyer/palenight.vim'})
  use({'glepnir/galaxyline.nvim', branch = 'main' })
  use({'nvim-treesitter/nvim-treesitter',
    run = {':TSUpdate'},
    branch = 'master'})
  use({'romgrk/nvim-treesitter-context'})
    -- branch = 'revert-1252-comment-combined'})
  -- use({'aquach/vim-http-client'})
  use({'~/Repositories/rest.nvim'})
  -- use({'mhinz/vim-signify'})
  use({'mhinz/vim-startify'})
  use({'tpope/vim-surround'})
  use({'mbbill/undotree', config = [[vim.g.undotree_SetFocusWhenToggle = 1]]})
-- Load on an autocommand event
  -- use({'andymass/vim-matchup', event = 'VimEnter'})
  use({'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  })
  use({'kyazdani42/nvim-tree.lua'})
  use({'tpope/vim-repeat'})
end)

-- Lazy loading:
-- Load on specific commands
-- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

-- Load on a combination of conditions: specific filetypes or commands
-- Also run code after load (see the "config" key)
-- use {
--   'w0rp/ale',
--   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
--   cmd = 'ALEEnable',
--   config = 'vim.cmd[[ALEEnable]]'
-- }

-- Plugins can also depend on rocks from luarocks.org:
-- use {
--   'my/supercoolplugin',
--   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
-- }

-- You can specify rocks in isolation
-- use_rocks 'penlight'
-- use_rocks {'lua-resty-http', 'lpeg'}

-- Plugins can have post-install/update hooks
-- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

-- Post-install/update hook with neovim command
-- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

-- Post-install/update hook with call of vimscript function with argument
-- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

-- Use dependency and run lua function after load
-- use {
  -- 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
  -- config = function() require('gitsigns').setup() end
-- }

-- You can specify multiple plugins in a single call
-- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}


-- Async building & commands
-- use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

-- Registers
-- use 'junegunn/vim-peekaboo'

-- Marks
-- use {'kshenoy/vim-signature', config = [[require('config.signature')]], disable = true}

-- Buffer management
-- use {'mhinz/vim-sayonara', cmd = 'Sayonara'}

-- Movement
-- use {'chaoren/vim-wordmotion', {'justinmk/vim-sneak', config = [[require('config.sneak')]]}}

-- Quickfix
-- use {'Olical/vim-enmasse', cmd = 'EnMasse'}

-- Indentation tracking
-- use {
--   'lukas-reineke/indent-blankline.nvim',
--   branch = 'lua',
--   setup = [[require('config.indentline')]]
-- }

-- Commenting
-- use 'tomtom/tcomment_vim'

-- Wrapping/delimiters
-- use {'machakann/vim-sandwich', {'andymass/vim-matchup', setup = [[require('config.matchup')]]}}

-- Search
-- use 'romainl/vim-cool'

-- Prettification
-- use {'junegunn/vim-easy-align', config = [[require('config.easy_align')]]}
-- use {'mhartington/formatter.nvim', config = [[require('config.format')]]}

-- Text objects
-- use 'wellle/targets.vim'

-- Search
-- use {
--   'nvim-telescope/telescope.nvim',
--   requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
--   setup = [[require('config.telescope_setup')]],
--   config = [[require('config.telescope')]],
--   cmd = 'Telescope'
-- }

-- use {'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sql.nvim'}

-- Project Management/Sessions
-- use {
--   'dhruvasagar/vim-prosession',
--   after = 'vim-obsession',
--   requires = {{'tpope/vim-obsession', cmd = 'Prosession'}},
--   config = [[require('config.prosession')]]
-- }

-- Undo tree
-- use {
--   'mbbill/undotree',
--   cmd = 'UndotreeToggle',
--   config = [[vim.g.undotree_SetFocusWhenToggle = 1]]
-- }

-- Completion and linting
-- use {
--   'onsails/lspkind-nvim', 'neovim/nvim-lspconfig', '~/projects/personal/lsp-status.nvim',
--   'glepnir/lspsaga.nvim'
-- }

-- Highlights
-- use {
--   'nvim-treesitter/nvim-treesitter',
--   requires = {
--     'nvim-treesitter/nvim-treesitter-refactor', 'nvim-treesitter/nvim-treesitter-textobjects'
--   },
--   config = [[require('config.treesitter')]]
-- }

-- use {'hrsh7th/nvim-compe', config = [[require('config.compe')]], event = 'InsertEnter *'}

-- Debugger
-- use {'mfussenegger/nvim-dap', opt = true}
-- use {
--   'puremourning/vimspector',
--   setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
--   disable = true
-- }

-- Path navigation
-- use 'justinmk/vim-dirvish'

-- Profiling
-- use {'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]]}

-- Highlight colors
-- use {
--   'norcalli/nvim-colorizer.lua',
--   ft = {'css', 'javascript', 'vim', 'html'},
--   config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html'}]]
-- }

