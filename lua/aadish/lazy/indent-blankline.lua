return {
    -- Indent guides for Neovim
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "BufReadPost", -- Load when a buffer is read
        config = function()
            require('ibl').setup({
                indent = {
                    char = "▍", -- Bold vertical line for indentation
                },
                -- Global configurations
                scope = {
                    enabled = false, -- Example option to disable scope highlighting
                },
            })

            -- Set color for the indentation guide
            vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = "#5eacd3", nocombine = true })

            -- Disable indent-blankline for nvim-tree
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "NvimTree", "undotree", "mason" },
                callback = function()
                    vim.b.indent_blankline_enabled = false
                end,
            })
        end
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        event = "BufReadPost", -- Load when a buffer is read
        config = function()
            require('mini.indentscope').setup({
                -- Draw options
                draw = {
                    delay = 0,                                                -- No delay between event and start of drawing scope indicator
                    animation = require('mini.indentscope').gen_animation.none(), -- No animation for instant appearance
                    priority = 2,                                             -- Symbol priority
                },
                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    object_scope = 'ii',         -- Textobjects
                    object_scope_with_border = 'ai', -- Textobjects with border
                    goto_top = '[i',             -- Jump to top border
                    goto_bottom = ']i',          -- Jump to bottom border
                },
                -- Options which control scope computation
                options = {
                    border = 'both', -- Type of scope's border
                    indent_at_cursor = false, -- Use cursor column for computing reference indent
                    try_as_border = false, -- Check if input line is a border of adjacent scope
                },
                symbol = "▍", -- Character used for drawing scope indicator
            })

            -- Set color for the scope symbol
            vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = "#e06c75" })

            -- Disable mini.indentscope for specific filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "NvimTree", "undotree", "mason", "lazy" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end
    },
}
