-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Insert a line up/down in normal mode
keymap.set("n", "O", "O<Esc>")
keymap.set("n", "o", "o<Esc>")

-- Switch to normal mode
keymap.set({ "i", "c" }, "jf", "<Esc>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set("n", "dw", "vb_d")

-- Select all
keymap.set("n", "<C-a>", "ggVG")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

--New tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<S-tab>", ":tabprev<CR>", opts)

-- Split window
keymap.set("n", "ss", ":split<CR>", opts)
keymap.set("n", "sv", ":vsplit<CR>", opts)

-- Move window
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><", opts)
keymap.set("n", "<C-w><right>", "<C-w>>", opts)
keymap.set("n", "<C-w><up>", "<C-w>+", opts)
keymap.set("n", "<C-w><down>", "<C-w>-", opts)

-- Open/Close Terminal
keymap.set("n", "<c-\\>", function()
  LazyVim.terminal()
end, { desc = "Terminal (cwd Dir)" })
keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Jump next/prev word in InsertMode
vim.keymap.set("i", "<C-f>", "<Esc>l<cmd>lua require('spider').motion('w')<CR>i")
vim.keymap.set("i", "<C-b>", "<Esc><cmd>lua require('spider').motion('b')<CR>i")
