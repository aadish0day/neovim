return {
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup(
                { '*' },                     -- Highlight all file types.
                {
                    RGB      = true,         -- #RGB hex codes
                    RRGGBB   = true,         -- #RRGGBB hex codes
                    names    = true,         -- "Name" codes like Blue
                    RRGGBBAA = true,         -- #RRGGBBAA hex codes
                    rgb_fn   = true,         -- CSS rgb() and rgba() functions
                    hsl_fn   = true,         -- CSS hsl() and hsla() functions
                    css      = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn   = true,         -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    mode     = 'background', -- Set the display mode.
                }
            )
        end
    },
    {
        "ziontee113/color-picker.nvim",
        config = function()
            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<leader>cp", "<cmd>PickColor<cr>", opts)
            -- vim.keymap.set("i", "<leader>cp", "<cmd>PickColorInsert<cr>", opts)

            require("color-picker").setup({
                ["icons"] = { "ﱢ", "" },
                -- ["icons"] = { "ﮊ", "" },
                -- ["icons"] = { "", "ﰕ" },
                -- ["icons"] = { "", "" },
                -- ["icons"] = { "", "" },
                -- ["icons"] = { "ﱢ", "" },
                ["border"] = "rounded",
                ["keymap"] = {
                    ["U"] = "<Plug>ColorPickerSlider5Decrease",
                    ["O"] = "<Plug>ColorPickerSlider5Increase",
                },
                ["background_highlight_group"] = "Normal",
                ["border_highlight_group"] = "FloatBorder",
                ["text_highlight_group"] = "Normal",
            })

            vim.cmd([[hi FloatBorder guibg=NONE]])
            vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
        end,
    },
    {
        "vi013t/easycolor.nvim",
        dependencies = { "stevearc/dressing.nvim" }, -- Optional, but provides better UI for editing the formatting template
        opts = {},
        keys = { { "<leader>b", "<cmd>EasyColor<cr>", desc = "Color Picker" } }
    }
}
