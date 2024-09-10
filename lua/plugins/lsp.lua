return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "emmet-language-server",
        "pyright",
        "clangd",
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    -- init = function()
    --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
    --   keys[#keys + 1] = {
    --     "gd",
    --     function()
    --       -- DO NOT RESUSE WINDOW
    --       require("telescope.builtin").lsp_definitions({ reuse_win = false })
    --     end,
    --     desc = "Goto Definition",
    --     has = "definition",
    --   }
    -- end,
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      -- ---@type lspconfig.options
      -- servers = {
      --   clangd = {
      --     cmd = { "clangd", "--background-index" },
      --     filetypes = { "c", "C", "cxx", "cc", "cpp" },
      --     root_dir = require("lspconfig.util").root_pattern(
      --       ".clangd",
      --       ".clang-tidy",
      --       ".clang-format",
      --       "compile_commands.json",
      --       "compile_flags.txt",
      --       "configure.ac",
      --       ".git",
      --       ".vscode"
      --     ),
      --   },
      --   cssls = {},
      --   tailwindcss = {
      --     root_dir = function(...)
      --       return require("lspconfig.util").root_pattern(".git")(...)
      --     end,
      --   },
      --   tsserver = {
      --     root_dir = function(...)
      --       return require("lspconfig.util").root_pattern(".git")(...)
      --     end,
      --     single_file_support = false,
      --     settings = {
      --       typescript = {
      --         inlayHints = {
      --           includeInlayParameterNameHints = "literal",
      --           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --           includeInlayFunctionParameterTypeHints = true,
      --           includeInlayVariableTypeHints = false,
      --           includeInlayPropertyDeclarationTypeHints = true,
      --           includeInlayFunctionLikeReturnTypeHints = true,
      --           includeInlayEnumMemberValueHints = true,
      --         },
      --       },
      --       javascript = {
      --         inlayHints = {
      --           includeInlayParameterNameHints = "all",
      --           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --           includeInlayFunctionParameterTypeHints = true,
      --           includeInlayVariableTypeHints = true,
      --           includeInlayPropertyDeclarationTypeHints = true,
      --           includeInlayFunctionLikeReturnTypeHints = true,
      --           includeInlayEnumMemberValueHints = true,
      --         },
      --       },
      --     },
      --   },
      --   html = {},
      --   yamlls = {
      --     settings = {
      --       yaml = {
      --         keyOrdering = false,
      --       },
      --     },
      --   },
      --   lua_ls = {
      --     -- enabled = false,
      --     single_file_support = true,
      --     settings = {
      --       Lua = {
      --         workspace = {
      --           checkThirdParty = false,
      --         },
      --         completion = {
      --           workspaceWord = true,
      --           callSnippet = "Both",
      --         },
      --         misc = {
      --           parameters = {
      --             -- "--log-level=trace",
      --           },
      --         },
      --         hint = {
      --           enable = true,
      --           setType = false,
      --           paramType = true,
      --           paramName = "Disable",
      --           semicolon = "Disable",
      --           arrayIndex = "Disable",
      --         },
      --         doc = {
      --           privateName = { "^_" },
      --         },
      --         type = {
      --           castNumberToInteger = true,
      --         },
      --         diagnostics = {
      --           disable = { "incomplete-signature-doc", "trailing-space" },
      --           -- enable = false,
      --           groupSeverity = {
      --             strong = "Warning",
      --             strict = "Warning",
      --           },
      --           groupFileStatus = {
      --             ["ambiguity"] = "Opened",
      --             ["await"] = "Opened",
      --             ["codestyle"] = "None",
      --             ["duplicate"] = "Opened",
      --             ["global"] = "Opened",
      --             ["luadoc"] = "Opened",
      --             ["redefined"] = "Opened",
      --             ["strict"] = "Opened",
      --             ["strong"] = "Opened",
      --             ["type-check"] = "Opened",
      --             ["unbalanced"] = "Opened",
      --             ["unused"] = "Opened",
      --           },
      --           unusedLocalExclude = { "_*" },
      --         },
      --         format = {
      --           enable = false,
      --           defaultConfig = {
      --             indent_style = "space",
      --             indent_size = "2",
      --             continuation_indent_size = "2",
      --           },
      --         },
      --       },
      --     },
      --   },
      -- },
      setup = {},
    },
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
