return {
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- for file icons
        config = function()
            require("oil").setup({})
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open file explorer" })
        end
    }
}

