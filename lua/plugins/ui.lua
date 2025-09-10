return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "xiyaowong/transparent.nvim",
    },
    lazy = true,
    event = "BufReadPre",
    priority = 1000,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      opts.presets.lsp_doc_border = true
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  --- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = { theme = "catppuccin" }
      table.insert(opts.sections.lualine_x, "fileformat")
      opts.sections.lualine_z = { "encoding", "filesize" }
    end,
  },

  -- filename
  {
    "b0o/incline.nvim",
    enabled = false,
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#363944",
          }
          return buffer
        end,
      })
    end,
  },

  -- database
  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod", lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     -- Your DBUI configuration
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  --   keys = {
  --     {
  --       "<leader>d",
  --       "<cmd>Neotree<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
  --       desc = "DataBaseUI",
  --     },
  --   },
  -- },
  {
    "ibhagwan/fzf-lua",
    config = function()
      local preview_cmd_chafa = { "chafa", "{file}" }
      -- local preview_cmd_viu = { "viu", "-b" }
      -- local preview_cmd_ueberzug = { "ueberzug" }
      local image_extensions = {}
      for _, ext in ipairs({ "jpg", "svg", "png", "ico" }) do
        image_extensions[ext] = preview_cmd_chafa
      end
      require("fzf-lua").setup({
        previewers = {
          builtin = {
            extensions = image_extensions,
          },
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = true },
      dashboard = {
        sections = {
          {
            section = "terminal",
            cmd = "chafa ~/.config/pic/t1.png --format symbols --symbols vhalf --size 60x20 --stretch; sleep .1",
            height = 20,
            padding = 1,
          },
          {
            pane = 2,
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
        },
      },
      picker = {
        previewers = {
          diff = {
            builtin = false,
            cmd = "delta",
          },
          git = {
            builtin = false,
          },
        },
      },
    },
    keys = {
      {
        "<leader>gz",
        function()
          Snacks.lazygit.open()
        end,
        desc = "Lazygit",
      },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim", -- Powered by Tree-sitter
    submodules = false,
    opts = {
      strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua = 210,
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    },
    main = "rainbow-delimiters.setup",
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = { window = { border = "rounded" } },
      })
      opts.signature = { window = { border = "rounded" } }
      -- 设置补全菜单浮动窗口的背景透明
      -- 对于 Pmenu (补全菜单) 相关的高亮组，也可以尝试设置
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#3b3f52" })
    end,
  },
}
