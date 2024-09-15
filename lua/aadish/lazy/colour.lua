return {
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                -- Main options --
                style = 'deep',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = true,           -- Show/hide background
                term_colors = false,          -- Change terminal color as per the selected theme style
                ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
                cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments = 'italic',
                    keywords = 'italic,bold',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },

                -- Lualine options --
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },

                -- Custom Highlights --
                colors = {},     -- Override default colors
                highlights = {}, -- Override highlight groups

                -- Plugins Config --
                diagnostics = {
                    darker = true,     -- darker colors for diagnostic
                    undercurl = true,  -- use undercurl instead of underline for diagnostics
                    background = true, -- use background color for virtual text
                },
            }
            require('onedark').load()
        end
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- -- your configuration comes here
                -- -- or leave it empty to use the default settings
                -- style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                -- transparent = true, -- Enable this to disable setting the background color
                -- terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                -- styles = {
                --     -- Style to be applied to different syntax groups
                --     -- Value is any valid attr-list value for `:help nvim_set_hl`
                --     comments = { italic = false },
                --     keywords = { italic = false },
                --     -- Background styles. Can be "dark", "transparent" or "normal"
                --     sidebars = "dark", -- style for sidebars, see below
                --     floats = "dark", -- style for floating windows
                -- },
            })
        end
    },
}
