-- Vimwiki Neovim Configuration with Lazy Plugin Manager to use .md files

return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            require("obsidian").setup({
                dir = "~/Documents/Obsidian/",

                disable_frontmatter = true, -- Add this line to disable frontmatter

                completion = {
                    nvim_cmp = true,
                    min_chars = 2,
                },

                ui = {
                    enable = true,
                },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        build = ":call mkdp#util#install()",
        ft = { "markdown", "vimwiki" },
        config = function()
            -- Markdown Preview Settings
            vim.g.mkdp_auto_start = 0 -- Don't auto open preview
            vim.g.mkdp_auto_close = 1 -- Close preview when leaving markdown buffer
            vim.g.mkdp_refresh_slow = 0 -- Update in real-time
            vim.g.mkdp_command_for_global = 0 -- Only work on markdown files
            vim.g.mkdp_open_to_the_world = 0 -- Only open locally
            vim.g.mkdp_browser = ""  -- Use system default browser

            -- Custom preview settings
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
            }
        end,
        keys = {
            { "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
            { "<leader>mo", "<Cmd>MarkdownPreview<CR>",       desc = "Open Markdown Preview" },
            { "<leader>mc", "<Cmd>MarkdownPreviewStop<CR>",   desc = "Close Markdown Preview" },
        },
    },
}
