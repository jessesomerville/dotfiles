local map = vim.keymap.set

vim.g.mapleader = "-"

map("i", "jk", "<Esc>", { desc = "Exit insert mode with 'jk'" })

map("i", "<C-b>", "<Esc>^i", { desc = "move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move to end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Easier Split Navigation
-- Note: <C-w>j is functionally equivalent to <C-w><C-j>
map("n", "<C-j>", "<C-w>j", { desc = "switch window left" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window right" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window down" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window up" })

map("n", "<leader>x", vim.cmd.noh, { desc = "Clear search highlights" })
map("n", "<leader>sv", "<cmd>source $MYVIMRC<cr>", { desc = "Reload nvim config" })

-- Ctrl-Backspace behavior
map("i", "<C-BS>", "<C-w>", { noremap = true })
vim.opt.backspace = { "indent", "eol", "start" }

-- Move Selected Lines (Alt-j / Alt-k)
-- Normal Mode
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")

-- Insert Mode
map("i", "<A-j>", "<Esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<Esc><cmd>m .-2<cr>==gi")

-- Visual Mode
map("v", "<A-j>", ":m '>+1<cr>gv=gv")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- Run the current file
map("n", "<leader>sh", "<cmd>te %:p<cr>")
