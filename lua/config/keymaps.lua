-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Insert a line up/down in normal mode
keymap.set("n", "O", "O<Esc>", opts)
keymap.set("n", "o", "o<Esc>", opts)

-- Insert one line below in insert mode without break current line)
keymap.set(
  "i",
  "<C-j>",
  "<Esc>A<CR>",
  vim.tbl_extend("force", opts, { desc = "Insert new line below from anywhere in line" })
)

-- Add the default action for <leader>+k to open the URL with default browser
vim.keymap.set("n", "<leader>k", function()
  -- Get the word under the cursor (which could be a URL or keyword)
  local word = vim.fn.expand("<cWORD>")
  -- 如果光标下不是 URL，可以尝试获取整个行并查找 URL
  local line = vim.fn.getline(".")
  local url = line:match("https?://[%w-_%.%?%.:/%+=&@%%]+") or word
  if url then
    os.execute("cmd.exe /c start " .. url)
  else
    vim.lsp.buf.hover() -- 如果没有找到 URL，回退到 LSP 悬浮窗口
  end
end, vim.tbl_extend("force", opts, { desc = "Open a URL with default browser" }))

-- Switch to normal mode
keymap.set({ "i", "c" }, "jf", "<Esc>")

--New tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<S-tab>", ":tabprev<CR>", opts)

-- Split window
keymap.set("n", "ss", ":split<CR>", opts)
keymap.set("n", "sv", ":vsplit<CR>", opts)

-- Move window
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><", opts)
keymap.set("n", "<C-w><right>", "<C-w>>", opts)
keymap.set("n", "<C-w><up>", "<C-w>+", opts)
keymap.set("n", "<C-w><down>", "<C-w>-", opts)

-- Open/Close Terminal
keymap.set("n", "<c-\\>", function()
  LazyVim.terminal()
end, vim.tbl_extend("force", opts, { desc = "Terminal (cwd Dir)" }))
keymap.set("t", "<C-\\>", "<cmd>close<cr>", vim.tbl_extend("force", opts, { desc = "Hide Terminal" }))

-- Jump next/prev word in InsertMode
keymap.set("i", "<C-f>", "<Esc>l<cmd>lua require('spider').motion('w')<CR>i", opts)
keymap.set("i", "<C-b>", "<Esc><cmd>lua require('spider').motion('b')<CR>i", opts)
-- 取消.按键绑定
keymap.set("n", ".", "<Nop>", opts)

keymap.set("n", ";i", function()
  require("dap").step_into()
end, vim.tbl_extend("force", opts, { desc = "Step Into" }))

keymap.set("n", ";o", function()
  require("dap").step_out()
end, vim.tbl_extend("force", opts, { desc = "Step Out" }))

keymap.set("n", ";l", function()
  require("dap").step_over()
end, vim.tbl_extend("force", opts, { desc = "Step Over" }))
