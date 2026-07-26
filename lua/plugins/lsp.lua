---@module "mason"
---@module "mason-lspconfig"
---@module "lazy"
---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    ---@type MasonSettings
    opts = {
      pip = {
        upgrade_pip = false,
        install_args = { "-i", "https://pypi.tuna.tsinghua.edu.cn/simple" },
      },
      npm = {
        install_args = { "--registry", "https://registry.npmmirror.com" },
      },
      ui = {
        border = "rounded",
        backdrop = 100, -- The backdrop opacity
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@type MasonLspconfigSettings
    opts = {
      ensure_installed = {
        "bashls",
        "biome",
        "clangd",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "emmet_language_server",
        "eslint",
        "docker_language_server",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "oxfmt",
        "oxlint",
        "pyright",
        "ruff",
        "stylua",
        "tailwindcss",
        "taplo",
        "texlab",
        "ts_ls",
        "vtsls",
        "vue_ls",
        "yamlls",
      },
      automatic_enable = true,
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
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
              -- "-std=c++17",
              "--target=x86_64-w64-windows-gnu",
            },
          },
        },
      },
    },
  },
}
