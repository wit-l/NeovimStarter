-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.opt.cmdheight = 0
vim.opt.laststatus = 2
vim.opt.scrolloff = 10
vim.opt.splitkeep = "cursor"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.wrap = false
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
local home = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
local shell = "zsh"
local contains_c_users = string.find(home, "C:\\Users") ~= nil
if contains_c_users then
  shell = "pwsh"
end
vim.opt.shell = shell
