---@module "snacks"
---@module "bufferline"
---@module "neo-tree"
---@module "blink.cmp"
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
        width = 30,
      },
      filesystem = {
        filtered_items = { visible = false, hide_dotfiles = false },
        follow_current_file = { enabled = true, leave_dirs_open = true },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
      },
    },
  },

  -- dropbar - shows symbols in the window
  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPre",
  },
  -- noice.nvim - replaces the vim ui for messages, commands and more
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

  -- bufferline - fancy tabs
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    ---@type bufferline.UserConfig
    opts = {
      options = {
        mode = "buffers",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- lualine - statusline
  -- Windows branch fix for #1452 (path sep / vs \); drop when upstream merges.
  -- Trigger: Neovim enables 'shellslash' on Windows when 'shell' contains "sh"
  -- (pwsh/powershell), so expand() yields `/` paths while lualine walks with `\`.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    pin = true,
    opts = function(_, opts)
      opts.options.theme = "catppuccin-mocha"
      table.insert(opts.sections.lualine_x, "fileformat")
      opts.sections.lualine_z = { "encoding", "filesize" }

      -- Runtime fallback if the pinned plugin copy is refreshed without the fix.
      if vim.fn.has("win32") == 1 then
        local ok, git_branch = pcall(require, "lualine.components.branch.git_branch")
        if ok and git_branch and not git_branch.__win_sep_fix then
          local orig = git_branch.find_git_dir
          local update_current_git_dir
          for i = 1, 20 do
            local name, val = debug.getupvalue(orig, i)
            if not name then
              break
            end
            if name == "update_current_git_dir" then
              update_current_git_dir = val
              break
            end
          end
          git_branch.find_git_dir = function(dir_path)
            local from_autocmd = dir_path == nil
            local path = dir_path or vim.fn.expand("%:p:h")
            if package.loaded.oil then
              local oil_ok, oil = pcall(require, "oil")
              if oil_ok then
                local dir_ok, dir = pcall(oil.get_current_dir)
                if dir_ok and dir and dir ~= "" then
                  path = vim.fn.fnamemodify(dir, ":p:h")
                end
              end
            end
            if type(path) == "string" and path:match("term://.*") then
              path = vim.fn.expand(path:gsub("term://(.+)//.+", "%1"))
            end
            if type(path) == "string" then
              path = path:gsub("/", "\\")
            end
            local git_dir = orig(path)
            if from_autocmd and update_current_git_dir then
              update_current_git_dir(git_dir)
            end
            return git_dir
          end
          git_branch.__win_sep_fix = true
        end
      end
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

  -- snacks.nvim - collection of neovim tools
  {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
      image = { enabled = true },
      explorer = { replace_netrw = false, trash = false },
      words = { enabled = true },
      statuscolumn = {
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
    },
  },
  -- rainbow-delimiters - rainbow colored brackets
  {
    "hiphish/rainbow-delimiters.nvim",
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

  -- indent-blankline rainbow scope highlights
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      opts.scope = vim.tbl_deep_extend("force", opts.scope or {}, {
        highlight = highlight,
        show_start = true, -- restore horizontal line at scope start
      })
      return opts
    end,
    -- HIGHLIGHT_SETUP must be registered BEFORE ibl.setup().
    -- config overrides main="ibl" but replicates its setup call.
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      require("ibl").setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  -- blink.cmp - completion engine
  {
    "saghen/blink.cmp",
    ---@type blink.cmp.Config
    opts = {
      completion = {
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
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = { window = { border = "rounded" } },
      },
      -- merged with LazyVim: { preset = "enter", ["<C-y>"] = ... }
      keymap = {
        ["<A-i>"] = { "show", "show_documentation", "hide_documentation" },
      },
    },
    -- highlights are not blink opts; use init (do not set config — LazyVim owns setup)
    init = function()
      local function clear_cmp_bg()
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none" })
      end
      clear_cmp_bg()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("blink_cmp_transparent", { clear = true }),
        callback = clear_cmp_bg,
      })
    end,
  },
  {
    "luxvim/nvim-luxterm",
    pin = true,
    opts = {
      keymaps = {
        toggle_manager = "<C-\\>",
        prev_session = "<C-k>",
        next_session = "<C-j>",
        hide_terminal = "<C-q>",
      },
      session_as_buffer = false,
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    cond = function()
      if os.getenv("KITTY_WINDOW_ID") ~= nil or vim.g.neovide ~= nil then
        return false
      end
      return true
    end,
  },
}
