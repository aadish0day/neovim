-- Ensure true color support is enabled
vim.opt.termguicolors = true

-- Setup bufferline
require("bufferline").setup {
    options = {
        offsets = { {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true -- Enable the default separator, or set your own character
        } }
    }
}
-- Enable navigation through buffers
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- Close the current buffer
vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })
