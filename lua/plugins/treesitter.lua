---@module "lazy"
---@type LazySpec
return {
  -- LazyVim installs this with opts={}; wrap close_tag so `>` of TS generics
  -- like <Table<IDataType> does not insert </IDataType> or a premature </Table>.
  {
    "windwp/nvim-ts-autotag",
    opts = {},
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)
      local internal = require("nvim-ts-autotag.internal")
      local close_tag = internal.close_tag
      internal.close_tag = function()
        local ft = vim.bo.filetype
        if ft == "typescriptreact" or ft == "javascriptreact" or ft == "typescript" then
          local line = vim.api.nvim_get_current_line()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local before = line:sub(1, col)
          if before:match("[%w_%.]<%s*[^<>%s][^<>]*$") then
            return
          end
          local ok, node = pcall(vim.treesitter.get_node)
          while ok and node do
            local t = node:type()
            if t == "type_arguments" or t == "type_parameters" then
              return
            end
            node = node:parent()
          end
        end
        return close_tag()
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "jsdoc",
        "markdown",
        "markdown_inline",
        "query",
        "html",
        "html_tags",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "python",
        "tsx",
        "jsx",
        "xml",
        "vim",
        "vimdoc",
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
  },
}
