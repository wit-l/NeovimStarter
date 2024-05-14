# NeovimStarter

my neovim config

forked from https://github.com/LazyVim/starter.git
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

The display image is as follows
![nvim neo-tree](pic/nvim-neotree.png)
![nvim hover](pic/nvim-hover-1.png)
![nvim hover](pic/nvim-hover-2.png)
![nvim float window](pic/nvim-float-window.png)
![nvim term](pic/nvim-term.png)

My Terminal is WindowsTerminal(preview).

The config file of WT is [here](https://github.com/WittyCo/Dotfiles/blob/main/windows/WindowsTerminal/settings.json).

The default shortcut key for switching focus mode (wt terminal without border) is ALT+Z.

Require:

- [gcc/g++](https://winlibs.com/), It is suggested to download the gcc/g++ compiler with the ucrt runtime and LLVM/Clang/LLD/LLDB version, and **make c/cpp lsp clangd in lua/plugins/lsp.lua point to clangd.exe in this software package, otherwise, clangd can't find the standard library of c/cpp, resulting in abnormal syntax.**
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [tree-sitter](https://github.com/tree-sitter/tree-sitter)
- [fzf](https://github.com/junegunn/fzf)
- [Lua](https://github.com/DevelopersCommunity/cmake-lua)

Use anaconda to manage python environment, and neovim uses venv-selector plugin to switch python environment. **Pay attention to modifying anaconda path in lua/plugins/editor.lua.**
