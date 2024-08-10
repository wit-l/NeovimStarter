return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "python",
        "tsx",
        "typescript",
        "yaml",
        "toml",
        "astro",
        "cmake",
        "cpp",
        "c",
        "css",
        "fish",
        "gitignore",
        "go",
        "http",
        "java",
        "php",
        "rust",
        "scss",
        "sql",
        "graphql",
        "regex",
        "latex",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
