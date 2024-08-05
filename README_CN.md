# NeovimStarter

我的neovim配置文件(适用于Linux平台，windows平台请参考windows分支)

部分配置参考：[Effective NeoVim Setup for 2024.pdf](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/pdf/Effective%20NeoVim%20Setup%20for%202024.pdf)

根据[LazyVim](https://github.com/LazyVim/starter.git)修改而来

安装步骤参考[documentation](https://lazyvim.github.io/installation)

**注意克隆时将lazyvim的url替换为本仓库的url**

UI界面：
![nvim neo-tree](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-neotree.png)
![nvim hover](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-hover-1.png)
![nvim hover](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-hover-2.png)
![nvim float window](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-float-window.png)
![nvim term](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-term.png)
![nvim database](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-database.png)

演示所用终端为[Windows Terminal(preview)](https://github.com/microsoft/terminal)

WT的配置文件在 [这里](https://github.com/WittyCo/Dotfiles/blob/main/windows/WindowsTerminal/settings.json).

以上配置文件中规定的默认切换专注模式(WT无边框)快捷键为Alt+z.

可选依赖:

- [gcc/g++](https://gcc.gnu.org/) **编写c/cpp代码必需**

  使用包管理器安装，例如：`sudo apt install gcc g++`部分插件构建需要

- [fd](https://github.com/sharkdp/fd) **必需**

  用于快速查找文件/文件夹(快捷键<kbd>space</kbd>+<kbd>f</kbd>+<kbd>f</kbd>)

- [ripgrep](https://github.com/BurntSushi/ripgrep) **必需**

  用于查找某段关键字所在文件路径及行号

- [tree-sitter](https://github.com/tree-sitter/tree-sitter) **必需**

  通过构建语法树来提供各种高级功能（语法高亮，代码重构等）

- [fzf](https://github.com/junegunn/fzf) **建议安装**

  模糊搜索

- [Lua](https://github.com/DevelopersCommunity/cmake-lua) **必需！！！**

  用于配置Neovim的脚本语言

- [Maple Mono NF (CN)](https://github.com/subframe7536/maple-font) **可选**

  Nerd font类型字体（可以提供丰富的图标显示）

- [lazygit](https://github.com/jesseduffield/lazygit) （图形化git操作）**可选**

  快速安装建议：如果你已经安装了python或者anaconda，那么你可以通过pip/conda install lazygit来快速安装

- [Python](https://www.python.org/) **可选**

- [Node](https://nodejs.org/) **必需**

  众多提供代码补全等高级功能的Lsp插件都使用npm安装

本人使用anaconda管理python虚拟环境，在neovim上使用venv-selector插件来自动选择或切换python环境,**注意修改位于lua/plugins/editor.lua下的anaconda的路径（目前由于各平台python程序相对路径存在差异导致windows端该自动选择/切换python环境插件无法正常工作,类Unix平台无该问题）**
