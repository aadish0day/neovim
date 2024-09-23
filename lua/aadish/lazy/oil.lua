return {
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- for file icons
        config = function()
            require("oil").setup({
                -- Set Oil as the default file explorer
                default_file_explorer = true,

                -- Enable columns to show icons
                columns = {
                    "icon",
                },

                -- Buffer-local options for oil buffers
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },

                -- Window-local options for oil buffers
                win_options = {
                    wrap = false,
                    signcolumn = "no",
                    cursorcolumn = false,
                    foldcolumn = "0",
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = "nvic",
                },

                -- Show hidden files (files starting with ".")
                view_options = {
                    show_hidden = true,
                },

                -- Default key mappings
                use_default_keymaps = true,
            })
            -- Map "-" to open Oil file explorer
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open file explorer" })
        end
    }
}

