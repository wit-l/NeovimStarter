# NeovimStarter

My neovim config(Applicable to linux platform, please refer to windows branch for windows platform.)

Part of the configuration reference:[Effective NeoVim Setup for 2024.pdf](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/pdf/Effective%20NeoVim%20Setup%20for%202024.pdf)

forked from [LazyVim](https://github.com/LazyVim/starter.git)
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

**Pay attention to replace the url of lazyvim with the url of this repository when cloning.**

UI interface:
![nvim neo-tree](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-neotree.png)
![nvim hover](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-hover-1.png)
![nvim hover](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-hover-2.png)
![nvim float window](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-float-window.png)
![nvim term](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-term.png)
![nvim database](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-database.png)

My Terminal is [WindowsTerminal(preview)](https://github.com/microsoft/terminal).

The config file of WT is [here](https://github.com/WittyCo/Dotfiles/blob/main/windows/WindowsTerminal/settings.json).

The default shortcut key for switching focus mode (WT without border) is ALT+Z in my wt config.

Requirements:

- [gcc/g++](https://gcc.gnu.org/) **Required for c/cpp code**

  Using package manager to install, such as `sudo apt install gcc g++`. Some plugins need to be compiled.

- [fd](https://github.com/sharkdp/fd) **Required**

  Search files.

- [ripgrep](https://github.com/BurntSushi/ripgrep) **Required**

  Search content from files.

- [tree-sitter](https://github.com/tree-sitter/tree-sitter) **Required!!!**

  Provide advanced function by building syntax tree.

- [fzf](https://github.com/junegunn/fzf) **Recommended**

  Fuzzy search

- [Lua](https://github.com/DevelopersCommunity/cmake-lua) **Required!!!**

- [Maple Mono NF (CN)](https://github.com/subframe7536/maple-font) **Optional**

  a nerd font

- [lazygit](https://github.com/jesseduffield/lazygit) **Optional(A GUI for git)**

  Quick installation suggestion: You can install it with pip or conda if you have python or anaconda.

- [Python](https://www.python.org/) **Optional**

- [Node](https://nodejs.org/) **Required**

  Many plugins that provide advanced features such as code completion and refactoring are installed using npm.

I use anaconda to manage python virtual environment, and neovim uses venv-selector plugin to switch python environment. **Pay attention to modifying anaconda path in lua/plugins/editor.lua**
