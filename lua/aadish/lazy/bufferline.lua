return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'folke/tokyonight.nvim',
        },
        config = function()
            -- Tokyonight theme palette specifically for bufferline
            local c = require("tokyonight.colors").setup({ style = "moon" })
            local bg = c.bg
            local bg_dark = c.bg_dark
            local bg_fill = "#12131d"
            local bg_vis = "#1f2131"
            local fg = c.fg
            local fg_dark = "#636da6"
            local blue = c.blue
            local red = c.red
            local green = c.green
            local yellow = c.yellow

            local tokyonight_highlights = {
                fill = { bg = bg_fill },
                background = { fg = fg_dark, bg = bg_dark },
                buffer_visible = { fg = fg_dark, bg = bg_vis },
                buffer_selected = { fg = fg, bg = bg, bold = true, italic = true },
                tab = { fg = fg_dark, bg = bg_dark },
                tab_selected = { fg = blue, bg = bg, bold = true },
                tab_separator = { fg = bg_fill, bg = bg_dark },
                tab_separator_selected = { fg = bg_fill, bg = bg },
                tab_close = { fg = fg_dark, bg = bg_dark },
                close_button = { fg = fg_dark, bg = bg_dark },
                close_button_visible = { fg = fg_dark, bg = bg_vis },
                close_button_selected = { fg = red, bg = bg },
                separator = { fg = bg_fill, bg = bg_dark },
                separator_visible = { fg = bg_fill, bg = bg_vis },
                separator_selected = { fg = bg_fill, bg = bg },
                indicator_selected = { fg = c.git and c.git.change or blue, bg = bg },
                indicator_visible = { fg = bg_vis, bg = bg_vis },
                modified = { fg = green, bg = bg_dark },
                modified_visible = { fg = green, bg = bg_vis },
                modified_selected = { fg = green, bg = bg },
                duplicate = { fg = "#5e679d", bg = bg_dark, italic = true },
                duplicate_visible = { fg = "#5e679d", bg = bg_vis, italic = true },
                duplicate_selected = { fg = "#5e679d", bg = bg, italic = true },
                numbers = { fg = fg_dark, bg = bg_dark },
                numbers_visible = { fg = fg_dark, bg = bg_vis },
                numbers_selected = { fg = fg, bg = bg, bold = true, italic = true },
                diagnostic = { fg = "#4a517c", bg = bg_dark },
                diagnostic_visible = { fg = "#4a517c", bg = bg_vis },
                diagnostic_selected = { fg = "#969eb7", bg = bg, bold = true, italic = true },
                error = { fg = fg_dark, bg = bg_dark, sp = red },
                error_visible = { fg = fg_dark, bg = bg_vis },
                error_selected = { fg = red, bg = bg, bold = true, italic = true, sp = red },
                error_diagnostic = { fg = "#4a517c", bg = bg_dark, sp = red },
                error_diagnostic_visible = { fg = "#4a517c", bg = bg_vis },
                error_diagnostic_selected = { fg = red, bg = bg, bold = true, italic = true, sp = red },
                warning = { fg = fg_dark, bg = bg_dark, sp = yellow },
                warning_visible = { fg = fg_dark, bg = bg_vis },
                warning_selected = { fg = yellow, bg = bg, bold = true, italic = true, sp = yellow },
                warning_diagnostic = { fg = "#4a517c", bg = bg_dark, sp = yellow },
                warning_diagnostic_visible = { fg = "#4a517c", bg = bg_vis },
                warning_diagnostic_selected = { fg = yellow, bg = bg, bold = true, italic = true, sp = yellow },
                info = { fg = fg_dark, bg = bg_dark, sp = blue },
                info_visible = { fg = fg_dark, bg = bg_vis },
                info_selected = { fg = blue, bg = bg, bold = true, italic = true, sp = blue },
                info_diagnostic = { fg = "#4a517c", bg = bg_dark, sp = blue },
                info_diagnostic_visible = { fg = "#4a517c", bg = bg_vis },
                info_diagnostic_selected = { fg = blue, bg = bg, bold = true, italic = true, sp = blue },
                hint = { fg = fg_dark, bg = bg_dark, sp = c.hint or "#4fd6be" },
                hint_visible = { fg = fg_dark, bg = bg_vis },
                hint_selected = { fg = c.hint or "#4fd6be", bg = bg, bold = true, italic = true, sp = c.hint or "#4fd6be" },
                hint_diagnostic = { fg = "#4a517c", bg = bg_dark, sp = c.hint or "#4fd6be" },
                hint_diagnostic_visible = { fg = "#4a517c", bg = bg_vis },
                hint_diagnostic_selected = { fg = c.hint or "#4fd6be", bg = bg, bold = true, italic = true, sp = c.hint or "#4fd6be" },
                pick = { fg = red, bg = bg_dark, bold = true, italic = true },
                pick_visible = { fg = red, bg = bg_vis, bold = true, italic = true },
                pick_selected = { fg = red, bg = bg, bold = true, italic = true },
                offset_separator = { fg = "#1b1d2b", bg = bg_fill },
                trunc_marker = { fg = fg_dark, bg = bg_fill },
            }

            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    style_preset = require("bufferline").style_preset.default,
                    themable = false, -- Enforces Tokyonight highlights over onedark
                    
                    -- Aesthetic styling
                    separator_style = "slant", -- The "snazzy" slanted look
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    
                    -- LSP Diagnostics integration
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " "
                                or (e == "warning" and " " or " ")
                            s = s .. n .. sym
                        end
                        return s
                    end,

                    -- Modified / Unsaved indicators
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    modified_icon = '●',
                    indicator = {
                        style = 'icon',
                        icon = '▎',
                    },

                    -- File Explorer integration (Offsets)
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true
                        }
                    },

                    -- UI features
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = {'close'}
                    },
                },
                highlights = tokyonight_highlights,
            })

            -- Standard bracket navigation for buffer cycling (preserves standard <C-i> jumplist navigation)
            vim.keymap.set('n', '[b', '<Cmd>BufferLineCyclePrev<CR>', { desc = "Prev buffer" })
            vim.keymap.set('n', ']b', '<Cmd>BufferLineCycleNext<CR>', { desc = "Next buffer" })

            -- Tab / S-Tab convenience mappings
            vim.keymap.set('n', '<TAB>', '<Cmd>BufferLineCycleNext<CR>', { desc = "Next buffer" })
            vim.keymap.set('n', '<S-TAB>', '<Cmd>BufferLineCyclePrev<CR>', { desc = "Prev buffer" })
            vim.keymap.set('n', '<leader>q', '<Cmd>bdelete<CR>', { desc = "Delete buffer" })
        end
    },
}
