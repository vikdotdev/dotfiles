-- Leader/local leader before everything else
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'

  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
  end

  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.api.nvim_command('packadd packer.nvim')

require('plugins')
if not packer_bootstrap then
  require('config')
end
