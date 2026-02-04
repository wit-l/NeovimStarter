-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.scriptencoding = "utf-8"
local opt = vim.opt
opt.cmdheight = 0
opt.scrolloff = 4
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.path:append({ "**" })
opt.shell = "zsh"
opt.wrap = false
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
vim.o.fileencodings = "ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1"

-- neovide config($XDG_CONFIG_HOME/neovide/config.toml)
-- vim.o.guifont = "Maple Mono NF CN:h12"
vim.g.neovide_normal_opacity = 0.7
vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0
-- vim.g.mkdp_port = "8000"
