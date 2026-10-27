-- Display
vim.opt.number = true
vim.opt.wrap = false
vim.opt.scrolloff = 4
vim.opt.shortmess:append("I") -- Skip the intro screen

-- Indentation: two spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Search: ignore case unless the query contains a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Open splits below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Use the system clipboard and keep undo history between sessions
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

-- Ask whether to save unsaved changes
vim.opt.confirm = true
