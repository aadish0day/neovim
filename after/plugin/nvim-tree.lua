-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Key mapping to open NvimTree with Ctrl+f
vim.keymap.set('n', '<C-f>', ':NvimTreeOpen<CR>', { silent = true })

-- Setup NvimTree with options
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 25,
        float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = function()
                -- Constants for window dimensions ratios
                local WIDTH_RATIO = 0.8  -- You can adjust this value
                local HEIGHT_RATIO = 0.8 -- You can adjust this value

                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

                return {
                    border = "rounded",
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
    },
    renderer = {
        group_empty = false,
        highlight_opened_files = "all",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                item = "│ ",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "+",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
    },
    filters = {
        dotfiles = false,
    },
})
