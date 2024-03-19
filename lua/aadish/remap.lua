vim.g.mapleader = " "

-- Moving lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Joining lines without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Centering the view
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Enhancing search navigation
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over without overwriting the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete without overwriting the clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Escape more easily
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Keybinding for saving the file with Ctrl+s in normal, insert, and visual modes
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { silent = true })

-- Disable Ex mode mapping
vim.keymap.set("n", "Q", "<nop>")

-- LSP formatting shortcut
vim.keymap.set("n", "<leader>f", function()
    if vim.lsp.buf.format then
        vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
        vim.lsp.buf.formatting()
    end
end)

-- Quickfix and location list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Easy search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Autocommand for highlighting yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
    end,
})
