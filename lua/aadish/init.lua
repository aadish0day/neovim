require("aadish.remap")
require("aadish.set")
require("aadish.packer").compile()


-- Autocommand for highlighting yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
    end,
})
