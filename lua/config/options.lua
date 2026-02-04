-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.scrolloff = 4
vim.opt.splitkeep = "screen"
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.path:append({ "**" })
-- vim.opt.wrap = false
-- vim.opt.splitbelow = true -- Put new windows below current
-- vim.opt.splitright = true -- Put new windows right of current
vim.opt.shell = "pwsh"
vim.o.fileencodings = "ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1"
-- vim.g.mkdp_port = "8000"
