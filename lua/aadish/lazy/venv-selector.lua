return {
    {
        "linux-cultist/venv-selector.nvim",
        branch = "main", -- Explicitly switch to main
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap-python",
        },
        ft = "python", -- Lazy load on python files
        opts = {
            settings = {
                options = {
                    notify_user_on_venv_activation = true,
                },
            },
        },
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Virtual Environment" },
        },
    },
}
