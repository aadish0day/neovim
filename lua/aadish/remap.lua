-- Neovim Configurations
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
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
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { silent = true })
vim.keymap.set('i', '<C-s>', '<C-[><cmd>w<CR><C-o>', { silent = true })
vim.keymap.set('v', '<C-s>', '<C-c><cmd>w<CR>', { silent = true })

vim.keymap.set("n", "<leader>sa", "<cmd>wa<CR>", { silent = true })

-- Disable Ex mode mapping
vim.keymap.set("n", "Q", "<nop>")

-- LSP formatting shortcut
vim.keymap.set("n", "<leader>f", function()
    local buf_format = vim.lsp.buf.format or vim.lsp.buf.formatting
    if buf_format then
        buf_format()
    end
end)

-- Quick fix and location list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Easy search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Codeium keybindings
vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
-- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
-- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
-- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
