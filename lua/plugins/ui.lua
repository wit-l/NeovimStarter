---@module "neo-tree"
---@module "lazy"
---@type LazySpec
return {
  -- neo-tree file manager sidebar
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "^3.x",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "NeoTree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
    },
    ---@type neotree.Config
    opts = {
      close_if_last_window = false,
      window = {
        auto_expand_width = true,
      },
      filesystem = {
        filtered_items = { visible = false, hide_dotfiles = false },
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
      },
    },
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPre",
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
    opts = {
      options = {
        mode = "buffers",
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
      opts.options.theme = "catppuccin-mocha"
      table.insert(opts.sections.lualine_x, "fileformat")
      opts.sections.lualine_z = { "encoding", "filesize" }
    end,
  },

  -- incline - floating filename line
  {
    "b0o/incline.nvim",
    -- enabled = false,
    event = "BufReadPre",
    priority = 1200,
    enabled = false,
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
    ---@type snacks.Config
    opts = {
      image = {
        enabled = true,
      },
      explorer = { replace_netrw = false, trash = false },
      words = { enabled = true },
      statuscolumn = {
        enabled = true,
        folds = {
          open = true, -- show open fold icons
          git_hl = true, -- use Git Signs hl for fold icons
        },
      },
      indent = { enabled = true },
      dashboard = {
        sections = {
          {
            section = "terminal",
            -- cmd = "chafa 'C:/Users/witty/OneDrive/图片/Saved Pictures/SFW/background/rain.jpg' --format symbols --symbols vhalf --size 60x20 --stretch; sleep .1",
            cmd = "chafa "
              .. os.getenv("ONEDRIVE")
              .. "'/图片/Saved Pictures/SFW/background/rain.jpg' --size 60x20 --stretch; sleep .1",
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
        trigger = {
          show_on_insert = true,
          -- show_on_backspace = true,
        },
      })
      -- 设置补全菜单浮动窗口的背景透明
      -- 对于 Pmenu (补全菜单) 相关的高亮组，也可以尝试设置
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none" })
    end,
  },
}
