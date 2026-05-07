return {
    -- Indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost", -- Load when a buffer is read
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = false, -- Example option to disable scope highlighting
                },
            })
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = "*",
        event = "BufReadPost", -- Load when a buffer is read
        config = function()
            require("mini.indentscope").setup({
                -- Draw options
                draw = {
                    delay = 0,                                     -- No delay between event and start of drawing scope indicator
                    animation = require("mini.indentscope").gen_animation.none(), -- No animation for instant appearance
                    priority = 20,                                 -- Increased priority to ensure it shows over other guides
                },
                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    object_scope = "ii", -- Textobjects
                    object_scope_with_border = "ai", -- Textobjects with border
                    goto_top = "[i",  -- Jump to top border
                    goto_bottom = "]i", -- Jump to bottom border
                },
                -- Options which control scope computation
                options = {
                    border = "both", -- Type of scope's border
                    indent_at_cursor = false, -- Use cursor column for computing reference indent
                    try_as_border = true, -- Check if input line is a border of adjacent scope
                },
                symbol = "│", -- Using a more standard vertical bar
            })

            -- Function to set the highlight
            local function set_indentscope_hl()
                vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#e06c75", nocombine = true })
            end

            -- Set color initially
            set_indentscope_hl()

            -- Ensure color persists after colorscheme changes
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = set_indentscope_hl,
            })

            -- Disable mini.indentscope for specific filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "NvimTree", "undotree", "mason", "lazy", "oil" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}

