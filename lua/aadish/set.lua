vim.opt.nu = true  -- Enable line numbers
vim.opt.relativenumber = true  -- Display line numbers as relative to the line with the cursor

vim.opt.tabstop = 4  -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = 4  -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true  -- Convert tabs to spaces

vim.opt.smartindent = true  -- Automatically insert indents in a smart way

vim.opt.swapfile = false  -- Do not use a swapfile for the buffer
vim.opt.backup = false  -- Do not keep a backup file after saving
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Directory where undo files are stored
vim.opt.undofile = true  -- Save undo history to an undo file

vim.opt.cursorline = true  -- Highlight the current line
vim.opt.showcmd = true  -- Show command in the last line of the screen
vim.opt.showmode = false  -- Do not display the mode (e.g., --INSERT--) in the command line area

