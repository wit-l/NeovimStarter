# NeovimStarter

我的neovim配置文件

根据[LazyVim](https://github.com/LazyVim/starter.git)修改而来

部分配置参考：[Effective NeoVim Setup for 2024.pdf](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/pdf/Effective%20NeoVim%20Setup%20for%202024.pdf)

安装步骤参考[documentation](https://lazyvim.github.io/installation)
**注意克隆时将lazyvim的url替换为本仓库的url**

## UI界面

### 文件管理器（snacks-explorer)

打开文件管理器：<kbd>space</kbd>+<kbd>e</kbd>/<kbd>E</kbd>
![nvim explorer](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590250453161759025045064.png)

### 补全&提示文档（blink.cmp+lsp）

查看光标处变量的提示信息：<kbd>shift</kbd>+<kbd>k</kbd>
跳转浏览器访问光标下URL：<kbd>space</kbd>+<kbd>k</kbd>)。其中blink.cmp负责显示与窗口触发，数据来源为语言对应lsp。
![nvim hover](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17267351508081726735150586.png)
【注：<kbd>space</kbd>+<kbd>k</kbd>根据wsl2环境配置，完整Linux系统需要更改 `./lua/config/keymaps.lua#L28` 处的命令, 或者直接删除`#L19-L32`，使用vim内置的<kbd>gx</kbd>跳转到浏览器中指定页面】

### 重命名（lsp）

变量重命名（对光标下的）：<kbd>space</kbd>+<kbd>c</kbd>+<kbd>r</kbd>(需要lsp支持，将对整个项目范围有效)
![nvim rename](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-hover-2.png)

### 文件查找-根据文件/路径名（snacks-picker）

搜索并预览文件：<kbd>space</kbd>+<kbd>f</kbd><kbd>f</kbd>
![find files](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590253743121759025373411.png)

### 文件查找-根据文件内容（snacks-picker）

搜索并预览内容：<kbd>space</kbd>+<kbd>/</kbd>，回车直接跳转到指定行
![find files](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590271943101759027193496.png)

### Nvim 内置终端（snacks-terminal）

打开/关闭终端：<kbd>Ctrl</kbd>+<kbd>\\</kbd>or<kbd>/</kbd>
![nvim term](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590254603111759025460023.png)

### Debug（vim-dadbod）

<kbd>space</kbd>+<kbd>D</kbd>
![nvim database](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-database.png)
![debug cpp](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/debug.png)

演示所用终端为[Windows Terminal(preview)](https://github.com/microsoft/terminal)

WT的配置文件在 [这里](https://github.com/WittyCo/Dotfiles/blob/main/windows/WindowsTerminal/settings.json).

以上配置文件中规定的默认切换专注模式(WT无边框)快捷键为Alt+z.

## 可选依赖

- [gcc/g++](https://winlibs.com/) **编写c/cpp代码必需**

  推荐下载ucrt运行时且携带LLVM/Clang/LLD/LLDB版本的gcc/g++编译器
  **注意让lua/plugins/lsp.lua中的clangd的cmd的值为上述软件包中的clangd.exe的地址,否则,clangd将找不到c/c++标准库,从而导致lsp报错.**

- [fd](https://github.com/sharkdp/fd) **必需**

  用于快速查找文件/文件夹(快捷键<kbd>space</kbd>+<kbd>f</kbd>+<kbd>f</kbd>)

- [ripgrep](https://github.com/BurntSushi/ripgrep) **必需**

  在工作目录下查找某段关键字所在文件路径及行号

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

  众多提供代码补全等高级功能的Lsp插件都使用npm安装。

## 默认已安装的环境

默认安装的环境有"tailwindcss-language-server", "typescript-language-server", "html-lsp", "css-lsp", "emmet-language-server"(html, css快捷语法插件), "pyright"(Python lsp), "clangd"(C/C++ lsp)。对于不需要的环境，可以通过删除 `./lua/plugins/lsp.lua#L11-L17` 中对应的lsp 来卸载。

**注：venv-selector.nvim插件需要单独配置查询起始路径，若未安装python lsp可删除 `./lua/plugins/editor.lua#L203-L217` 中的venv-selector部分配置，只要有python lsp，LazyVim就会自动安装该插件。**
