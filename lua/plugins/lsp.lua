return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-language-server",
        "pyright",
      })
      opts.ui = {
        border = "rounded",
        backdrop = 100, -- The backdrop opacity
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = false,
      },
      ---@type lspconfig.options
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--query-driver=g++.exe", -- 指定编译器路径
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
          },
          init_options = {
            fallbackFlags = {
              "-std=c++17",
              "--target=x86_64-w64-windows-gnu",
            },
          },
        },
      },
    },
  },
}
