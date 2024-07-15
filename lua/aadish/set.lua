vim.opt.nu             = true                                 -- Enable line numbers.
vim.opt.relativenumber = true                                 -- Enable relative line numbers.
vim.opt.mouse          = ""                                   -- Disable mouse support.

vim.opt.tabstop        = 4                                    -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop    = 4                                    -- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.shiftwidth     = 4                                    -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab      = true                                 -- Convert tabs to spaces.

vim.opt.smartindent    = true                                 -- Enable smart indentation.

vim.opt.swapfile       = false                                -- Disable swapfile.
vim.opt.backup         = false                                -- Disable backup file.
vim.opt.undodir        = os.getenv("HOME") .. "/.vim/undodir" -- Set undo directory.
vim.opt.undofile       = true                                 -- Enable persistent undo.

vim.opt.cursorline     = true                                 -- Highlight the current line.
vim.opt.showmode       = false                                -- Disable mode display (like -- INSERT --).

vim.opt.termguicolors  = true                                 -- Enable 24-bit RGB color in the TUI.
vim.opt.scrolloff      = 8                                    -- Keep 8 lines visible above and below the cursor.

vim.opt.updatetime     = 50                                   -- Faster completion (default is 4000 ms).

vim.opt.signcolumn     = 'yes'                                -- Always show the sign column.
vim.opt.spelllang      = 'en_us'                              -- Set spell check language to US English.
vim.opt.spell          = true                                 -- Enable spell checking.

vim.opt.hlsearch       = true                                 -- Highlight all matches of search pattern.

