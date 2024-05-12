vim.opt.nu = true             -- Enable line numbers
vim.opt.relativenumber = true -- Display line numbers as relative to the line with the cursor
vim.opt.mouse = ""

vim.opt.tabstop = 4                                    -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4                                -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = 4                                 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true                               -- Convert tabs to spaces

vim.opt.smartindent = true                             -- Automatically insert indents in a smart way

vim.opt.swapfile = false                               -- Do not use a swapfile for the buffer
vim.opt.backup = false                                 -- Do not keep a backup file after saving
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory where undo files are stored
vim.opt.undofile = true                                -- Save undo history to an undo file

vim.opt.cursorline = true                              -- Highlight the current line
vim.opt.showmode = false                               -- Do not display the mode (e.g., --INSERT--) in the command line area

vim.opt.termguicolors = true                           -- Enable true color support
vim.opt.scrolloff = 8                                  -- Minimum number of lines to keep above and below the cursor

vim.opt.updatetime = 50                                -- Time in milliseconds to wait before triggering the plugin events

vim.opt.signcolumn = 'yes'

vim.opt.spelllang = 'en_us'
vim.opt.spell = true
