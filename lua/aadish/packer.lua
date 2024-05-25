-- Ensure Packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Packer configuration
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Plugin definitions

    -- nvim-treesitter for advanced syntax highlighting and more
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use({
        "aurum77/live-server.nvim",
        run = function()
            require "live_server.util".install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    })

    -- lualine for a fancy status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- telescope for fuzzy finding and more
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- undotree for visualizing vim undo history
    use 'mbbill/undotree'

    -- onedark theme for Neovim
    use 'navarasu/onedark.nvim'

    -- bufferline for managing buffers
    use {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- Required for various file icons
    use 'kyazdani42/nvim-web-devicons'

    -- nvim-tree for file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- indent-blankline for visually displaying indents
    use 'lukas-reineke/indent-blankline.nvim'

    -- gitsigns for git integration
    use 'lewis6991/gitsigns.nvim'

    -- To practice vim
    use 'ThePrimeagen/vim-be-good'

    -- Colorizer for highlighting color codes
    use 'norcalli/nvim-colorizer.lua'

    -- Which-key for displaying key bindings
    use 'folke/which-key.nvim'

    -- LSP configuration and related plugins
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'nvimtools/none-ls.nvim',
    }

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    -- Fidget for LSP progress
    use 'j-hui/fidget.nvim'

    -- Autopairs for automatic closing of brackets, quotes, etc.
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }

    -- Surround plugin for manipulating surrounding characters
    use {
        'kylechui/nvim-surround',
        tag = '*',
        config = function()
            require('nvim-surround').setup {}
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
