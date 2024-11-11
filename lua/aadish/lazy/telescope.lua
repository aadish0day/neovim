return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim", -- Added ui-select
        },
        config = function()
            -- Require and configure Telescope
            require("telescope").setup({
                defaults = {
                    -- Default configuration for Telescope goes here
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<C-k>"] = require("telescope.actions").move_selection_previous, -- Move to previous result
                            ["<C-j>"] = require("telescope.actions").move_selection_next, -- Move to next result
                        },
                    },
                },
                pickers = {
                    -- Default configuration for builtin pickers goes here
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- Additional options for ui-select
                        }),
                    },
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                },
            })

            -- Load Telescope extensions
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")

            -- Key mappings for Telescope
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})

            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "Fuzzy find in current buffer" })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
}
