-- Neovim Configurations
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
-- Normal mode uses <leader>D to prevent 1s hesitation conflict with DAP keymaps (<leader>db, <leader>dB, <leader>du)
vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "<leader>D", [["_d]], { desc = "Delete without yanking" })

-- Cut without overwriting the clipboard
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Escape more easily
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Keybinding for saving the file with Ctrl+s in normal, insert, and visual modes
-- Note: In tmux, <C-s> is often intercepted by the tmux prefix, so <leader>w / <leader>W are the recommended save bindings.
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<C-[><cmd>w<CR><C-o>", { silent = true })
vim.keymap.set("v", "<C-s>", "<C-c><cmd>w<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("v", "<leader>w", "<Esc><cmd>w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<CR>", { silent = true, desc = "Save all files" })

-- Disable Ex mode mapping
vim.keymap.set("n", "Q", "<nop>")

-- LSP and conform formatting shortcut (handled by conform.nvim in lua/aadish/lazy/format.lua)
-- vim.keymap.set("n", "<leader>f", function()
--     local buf_format = vim.lsp.buf.format or vim.lsp.buf.formatting
--     if buf_format then
--         buf_format()
--     end
-- end)

-- Quick fix and location list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Easy search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
