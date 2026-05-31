return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    style_preset = require("bufferline").style_preset.default,
                    
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
                highlights = {
                    indicator_selected = {
                        fg = '#e06c75', -- Onedark Red
                    },
                    buffer_selected = {
                        italic = true,
                        bold = true,
                    },
                }
            })

            -- Keep your existing keymaps
            vim.keymap.set('n', '<TAB>', '<Cmd>BufferLineCycleNext<CR>')
            vim.keymap.set('n', '<S-TAB>', '<Cmd>BufferLineCyclePrev<CR>')
            vim.keymap.set('n', '<leader>q', '<Cmd>bdelete<CR>')
        end
    },
}
