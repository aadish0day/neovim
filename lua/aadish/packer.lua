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
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- Live server
    use {
        "aurum77/live-server.nvim",
        run = function() require("live_server.util").install() end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" }
    }

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'nvim-telescope/telescope-ui-select.nvim'
    }
    -- Undo tree visualizer
    use 'mbbill/undotree'

    -- Theme
    use 'navarasu/onedark.nvim'

    -- Buffer line
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- File icons
    use 'kyazdani42/nvim-web-devicons'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Indent guides
    use 'lukas-reineke/indent-blankline.nvim'

    -- Git integration
    use 'lewis6991/gitsigns.nvim'

    -- Vim practice plugin
    use 'ThePrimeagen/vim-be-good'

    -- Color codes
    use 'norcalli/nvim-colorizer.lua'

    -- Display key bindings
    use 'folke/which-key.nvim'

    -- LSP and completion
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'nvimtools/none-ls.nvim'
    }

    -- Snippet engine
    use {
        "L3MON4D3/LuaSnip",
        tag = "v2.*",
        run = "make install_jsregexp"
    }

    -- LSP progress indicator
    use 'j-hui/fidget.nvim'

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function() require('nvim-autopairs').setup {} end
    }

    -- Surround manipulation
    use {
        'kylechui/nvim-surround',
        tag = '*',
    }

    use 'David-Kunz/gen.nvim'

    use {
        'Zeioth/compiler.nvim',
        requires = 'stevearc/overseer.nvim'
    }

    use "stevearc/oil.nvim"

    use { "akinsho/toggleterm.nvim", tag = '*'
    }
    use "tpope/vim-fugitive"

    use "sindrets/diffview.nvim"

    -- use 'Exafunction/codeium.vim'


    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
