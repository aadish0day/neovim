return {
    -- Onedark Theme - Set as Default
    {
        'navarasu/onedark.nvim',
        priority = 1000, -- Ensures the theme is loaded early
        config = function()
            require('onedark').setup {
                -- Main options --
                style = 'deep',               -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
                transparent = true,           -- Enables transparency
                term_colors = true,           -- Terminal colors match the theme
                ending_tildes = false,        -- Hides end-of-buffer tildes
                cmp_itemkind_reverse = false, -- Default item order in completion menu

                -- Code style options --
                code_style = {
                    comments = 'italic',      -- Italicize comments
                    keywords = 'bold,italic', -- Bold and italic keywords
                    functions = 'none',       -- No special style for functions
                    strings = 'none',         -- No special style for strings
                    variables = 'none'        -- No special style for variables
                },

                -- Lualine options --
                lualine = {
                    transparent = false, -- Transparent lualine to match the theme
                },

                -- Custom Highlights (optional) --
                colors = {},     -- Override default colors if needed
                highlights = {}, -- Customize highlight groups if needed

                -- Plugin specific options --
                diagnostics = {
                    darker = true,     -- Darker colors for diagnostics
                    undercurl = true,  -- Use undercurl for diagnostics
                    background = true, -- Background color for virtual text
                },
            }

            -- Load Onedark theme immediately
            require('onedark').load()
        end
    },
}
