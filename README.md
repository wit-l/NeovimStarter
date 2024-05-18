# NeovimStarter

my neovim config(Applicable to linux platform, please refer to windows branch for windows platform.)

forked from [LazyVim](https://github.com/LazyVim/starter.git)
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
**Pay attention to replace the url of lazyvim with the url of this repository when cloning.**

The display images are as follows
![nvim neo-tree](https://github.com/wit-l/NeovimStarter/blob/windows/pic/nvim-neotree.png)
![nvim hover](https://github.com/wit-l/NeovimStarter/blob/windows/pic/nvim-hover-1.png)
![nvim hover](https://github.com/wit-l/NeovimStarter/blob/windows/pic/nvim-hover-2.png)
![nvim float window](https://github.com/wit-l/NeovimStarter/blob/windows/pic/nvim-float-window.png)
![nvim term](https://github.com/wit-l/NeovimStarter/blob/windows/pic/nvim-term.png)
![nvim database](https://github.com/wit-l/NeovimStarter/blob/windows/pic/nvim-database.png)

My Terminal is [WindowsTerminal(preview)](https://github.com/microsoft/terminal).

The config file of WT is [here](https://github.com/WittyCo/Dotfiles/blob/main/windows/WindowsTerminal/settings.json).

The default shortcut key for switching focus mode (WT without border) is ALT+Z in my wt config.

Optional Requirements:

- [gcc/g++](https://winlibs.com/)
  Some plugins need to be compiled.
- [fd](https://github.com/sharkdp/fd)
  Search files.
- [ripgrep](https://github.com/BurntSushi/ripgrep)
  Search content from files.
- [tree-sitter](https://github.com/tree-sitter/tree-sitter)
  Provide advanced function by building syntax tree.
- [fzf](https://github.com/junegunn/fzf)
  Fuzzy search
- [Lua](https://github.com/DevelopersCommunity/cmake-lua)
- [Maple Mono NF (CN)](https://github.com/subframe7536/maple-font)
  a nerd font
- [lazygit](https://github.com/jesseduffield/lazygit)
  Quick installation suggestion: You can install it with pip or conda if you have python or anaconda.
- [Python](https://www.python.org/)
- [Node](https://nodejs.org/)

I use anaconda to manage python virtual environment, and neovim uses venv-selector plugin to switch python environment. **Pay attention to modifying anaconda path in lua/plugins/editor.lua**
