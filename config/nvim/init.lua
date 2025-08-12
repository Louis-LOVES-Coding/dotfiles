-- 🌟 Neovim Starter Config (init.lua)

-- 📁 Leader & Lazy Setup
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- 🔌 Plugin Setup
require("lazy").setup("plugins")

-- 🌈 UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true

-- 🖱️ Mouse & Clipboard
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- 🔍 Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- 🧼 Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 💾 Files
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undo", "p")
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ⚙️ Behavior
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 500

-- 📝 Syntax
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- 📁 NvimTree toggle
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- 🔍 Telescope keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
 



-- 🔧 Load custom modules
require("config.cmp")
require("config.lsp")

