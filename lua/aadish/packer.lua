-- Ensure Packer is installed
local ensure_packer = function()
    local fn = vim.fn
    -- Define the install path for Packer
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    -- Check if Packer is installed; if not, clone Packer from GitHub into the correct directory
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true -- Return true to indicate that Packer was not previously installed
    end
    return false    -- Return false to indicate that Packer was already installed
end

-- Attempt to ensure Packer is installed, and store the result
local packer_bootstrap = ensure_packer()

-- Packer configuration
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Plugin definitions
    -- nvim-treesitter for advanced syntax highlighting and more
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- lualine for a fancy status lines
    use 'Famiu/feline.nvim'

    -- telescope for fuzzy finding and more
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- fidget for LSP progress
    use {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end
    }

    -- undotree for visualizing vim undo history
    use 'mbbill/undotree'

    -- onedark theme for Neovim
    use 'navarasu/onedark.nvim'

    -- bufferline for managing buffers
    use { 'akinsho/bufferline.nvim', tag = "*" }

    -- Required for various file icons
    use 'nvim-tree/nvim-web-devicons'

    -- nvim-tree for file explorer
    use 'nvim-tree/nvim-tree.lua'

    -- indent-blankline for visually displaying indents
    use 'lukas-reineke/indent-blankline.nvim'

    -- gitsigns for git integration
    use 'lewis6991/gitsigns.nvim'

    -- To pratice vim
    use 'ThePrimeagen/vim-be-good'

    use 'norcalli/nvim-colorizer.lua'

    use 'folke/which-key.nvim'

    -- Lsp starts
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-path",
    }
    -- lsp stops

    -- Automatically set up your configuration after cloning packer.nvim
    -- so Neovim doesn't have to be restarted
    if packer_bootstrap then
        require('packer').sync()
    end
end)
