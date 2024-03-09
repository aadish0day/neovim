-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Begin Packer bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth', '1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	})
	vim.cmd [[packadd packer.nvim]]
end
-- End Packer bootstrap

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Your plugins here
	use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end
	}
use 'mbbill/undotree'
use 'navarasu/onedark.nvim'
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end

end)

