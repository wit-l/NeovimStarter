# NeovimStarter

My neovim config

Forked from [LazyVim](https://github.com/LazyVim/starter.git)

Part of the configuration reference:[Effective NeoVim Setup for 2024.pdf](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/pdf/Effective%20NeoVim%20Setup%20for%202024.pdf)

Refer to the [documentation](https://lazyvim.github.io/installation) to **get started**.

**Pay attention to replace the url of lazyvim with the url of this repository when cloning.**

## UI interface

### File explorer（snacks-explorer)

Open file explorer: <kbd>space</kbd>+<kbd>e</kbd>/<kbd>E</kbd>
![nvim explorer](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590250453161759025045064.png)

### Completion&documentation（blink.cmp+lsp）

Show var info under the cursor: <kbd>shift</kbd>+<kbd>k</kbd>

Open the URL under the cursor with the default browser: <kbd>space</kbd>+<kbd>k</kbd>. Blink.cmp is responsible for display and window triggering, and the data source is lsp corresponding to language.
![nvim hover](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17267351508081726735150586.png)

**Note: <kbd>space</kbd>+<kbd>k</kbd> According to the wsl2 environment configuration, the complete Linux system needs to change the command at `./lua/config/keymaps.lua#L28`, or directly delete `#L19-L32` and use <kbd>gx</kbd> built in vim to jump to the specified page in the browser.**

### Variable Rename（lsp）

Rename a variable: <kbd>space</kbd>+<kbd>c</kbd>+<kbd>r</kbd>
![nvim rename](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-hover-2.png)

### File finds-according to file name/path.（snacks-picker）

Search and Preview files: <kbd>space</kbd>+<kbd>f</kbd><kbd>f</kbd>
![find files](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590253743121759025373411.png)

### File finds-according to file content（snacks-picker）

Search and Preview files content: <kbd>space</kbd>+<kbd>/</kbd>
![find files](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590271943101759027193496.png)

### Nvim built-in terminal（snacks-terminal）

Open / Close the terminal: <kbd>Ctrl</kbd>+<kbd>\\</kbd>or<kbd>/</kbd>
![nvim term](https://cdn.jsdelivr.net/gh/wit-l/filebed@main/images/17590254603111759025460023.png)

### Debug（vim-dadbod）

<kbd>space</kbd>+<kbd>D</kbd>
![nvim database](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/nvim-database.png)
![debug cpp](https://cdn.jsdelivr.net/gh/wit-l/static_resources@latest/images/pic/debug.png)

My Terminal is [WindowsTerminal(preview)](https://github.com/microsoft/terminal).

The config file of WT is [here](https://github.com/WittyCo/Dotfiles/blob/main/windows/WindowsTerminal/settings.json).

The default shortcut key for switching focus mode (WT without border) is ALT+Z in my wt config.

Requirements:

- [gcc/g++](https://winlibs.com/) **Required for c/cpp code**

  It is suggested to download the gcc/g++ compiler with the ucrt runtime and LLVM/Clang/LLD/LLDB version.
  **Make c/cpp lsp--clangd in lua/plugins/lsp.lua point to clangd.exe in this software package, otherwise, clangd can't find the standard library of c/cpp, resulting in abnormal syntax.**

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

## Default installed environment

The default environment(lsp plugins) are "tailwindcss-language-server", "typescript-language-server", "html-lsp", "css-lsp", "emmet-language-server"(for emmet.io), "pyright"(Python), "clangd"(C/C++). Unnecessary environment can delete the corresponding lsp in `./lua/plugins/lsp.lua#L11-L17`.

**Note: venv-selector.nvim plugin needs to configure the query starting path separately. If there is no python environment, you can delete the partial configuration of venv-selector in `./Lua/plugins/editor.Lua#L203-L217`, but LazyVim will automatically install the plugin as long as there is a python environment configured.**
