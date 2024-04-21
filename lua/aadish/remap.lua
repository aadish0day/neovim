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

-- Cut without overwriting the clipboard
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Escape more easily
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Keybinding for saving the file with Ctrl+s in normal, insert, and visual modes
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { silent = true })

vim.keymap.set({ "n", "i", "v" }, "<C-S>", "<cmd>:wa<CR>", { silent = true })

-- Split the window horizontally with Ctrl-h
vim.keymap.set('n', '<C-h>', ':split<CR>', { silent = true })

-- Split the window vertically with Ctrl-v
vim.keymap.set('n', '<C-v>', ':vsplit<CR>', { silent = true })

-- Disable Ex mode mapping
vim.keymap.set("n", "Q", "<nop>")

-- LSP formatting shortcut
vim.keymap.set("n", "<leader>f", function()
    local buf_format = vim.lsp.buf.format or vim.lsp.buf.formatting
    if buf_format then
        buf_format()
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
