return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        config = function()
            require("barbar").setup({
                animation = true,
                auto_hide = false,
                tabpages = true,
            })

            vim.api.nvim_set_keymap("n", "<TAB>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<S-TAB>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>q", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
        end,
        version = "^1.0.0",
    },
}
