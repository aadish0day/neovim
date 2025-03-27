-- Vimwiki Neovim Configuration with Lazy Plugin Manager to use .md files

return {
    {
        "vimwiki/vimwiki",
        lazy = false,
        init = function()
            -- Explicitly set wiki to use Markdown and .md extension
            vim.g.vimwiki_list = {
                {
                    path = "~/vimwiki/",
                    syntax = "markdown",
                    ext = ".md",
                },
            }

            -- Force Markdown syntax
            vim.g.vimwiki_ext = ".md"
            vim.g.vimwiki_global_ext = 0 -- Disable global wiki extension
        end,
        config = function()
            -- Additional Vimwiki configurations
            vim.g.vimwiki_markdown_link_ext = 1 -- Include file extension in links
            vim.g.vimwiki_auto_header = 1 -- Automatically create header for new pages
        end,
        keys = {
            { "<leader>ww", "<Plug>VimwikiIndex",      desc = "Open Vimwiki Index" },
            { "<leader>wd", "<Plug>VimwikiDeleteLink", desc = "Delete Wiki Link" },
            { "<leader>wr", "<Plug>VimwikiRenameLink", desc = "Rename Wiki Link" },
        },
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
