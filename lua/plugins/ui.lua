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
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1500,
    },
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
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
      opts.sections.lualine_c = vim.tbl_extend("force", opts.sections.lualine_c, { "fileformat" })
      opts.sections.lualine_z = { "encoding", "filesize" }
    end,
  },
  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
        desc = "lazygit",
      },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
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
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {
        "<leader>d",
        "<cmd>Neotree<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
        desc = "DataBaseUI",
      },
    },
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

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
  -- dashboard
  {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local logo = {
        "⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷",
        "⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇",
        "⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽",
        "⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕",
        "⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕",
        "⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕",
        "⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄",
        "⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕",
        "⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿",
        "⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟",
        "⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠",
        "⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙",
        "⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣",
      }
      dashboard.section.header.val = logo
      alpha.setup(dashboard.opts)
    end,
  },
  -- {
  --   "goolord/alpha-nvim",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     local dashboard = require("alpha.themes.dashboard")
  --
  --     -- helper function for utf8 chars
  --     local function getCharLen(s, pos)
  --       local byte = string.byte(s, pos)
  --       if not byte then
  --         return nil
  --       end
  --       return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
  --     end
  --
  --     local function applyColors(logo, colors, logoColors)
  --       dashboard.section.header.val = logo
  --
  --       for key, color in pairs(colors) do
  --         local name = "Alpha" .. key
  --         vim.api.nvim_set_hl(0, name, color)
  --         colors[key] = name
  --       end
  --
  --       dashboard.section.header.opts.hl = {}
  --       for i, line in ipairs(logoColors) do
  --         local highlights = {}
  --         local pos = 0
  --
  --         for j = 1, #line do
  --           local opos = pos
  --           pos = pos + getCharLen(logo[i], opos + 1)
  --
  --           local color_name = colors[line:sub(j, j)]
  --           if color_name then
  --             table.insert(highlights, { color_name, opos, pos })
  --           end
  --         end
  --
  --         table.insert(dashboard.section.header.opts.hl, highlights)
  --       end
  --       return dashboard.opts
  --     end
  --
  --     require("alpha").setup(applyColors({
  --       [[  ███       ███  ]],
  --       [[  ████      ████ ]],
  --       [[  ████     █████ ]],
  --       [[ █ ████    █████ ]],
  --       [[ ██ ████   █████ ]],
  --       [[ ███ ████  █████ ]],
  --       [[ ████ ████ ████ ]],
  --       [[ █████  ████████ ]],
  --       [[ █████   ███████ ]],
  --       [[ █████    ██████ ]],
  --       [[ █████     █████ ]],
  --       [[ ████      ████ ]],
  --       [[  ███       ███  ]],
  --       [[                    ]],
  --       [[  N  E  O  V  I  M  ]],
  --     }, {
  --       ["b"] = { fg = "#3399ff", ctermfg = 33 },
  --       ["a"] = { fg = "#53C670", ctermfg = 35 },
  --       ["g"] = { fg = "#39ac56", ctermfg = 29 },
  --       ["h"] = { fg = "#33994d", ctermfg = 23 },
  --       ["i"] = { fg = "#33994d", bg = "#39ac56", ctermfg = 23, ctermbg = 29 },
  --       ["j"] = { fg = "#53C670", bg = "#33994d", ctermfg = 35, ctermbg = 23 },
  --       ["k"] = { fg = "#30A572", ctermfg = 36 },
  --     }, {
  --       [[  kkkka       gggg  ]],
  --       [[  kkkkaa      ggggg ]],
  --       [[ b kkkaaa     ggggg ]],
  --       [[ bb kkaaaa    ggggg ]],
  --       [[ bbb kaaaaa   ggggg ]],
  --       [[ bbbb aaaaaa  ggggg ]],
  --       [[ bbbbb aaaaaa igggg ]],
  --       [[ bbbbb  aaaaaahiggg ]],
  --       [[ bbbbb   aaaaajhigg ]],
  --       [[ bbbbb    aaaaajhig ]],
  --       [[ bbbbb     aaaaajhi ]],
  --       [[ bbbbb      aaaaajh ]],
  --       [[  bbbb       aaaaa  ]],
  --       [[                    ]],
  --       [[  a  a  a  b  b  b  ]],
  --     }))
  --   end,
  -- },
}
