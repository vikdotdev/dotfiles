-- Leader/local leader before everything else
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('plugins')
require('config')

