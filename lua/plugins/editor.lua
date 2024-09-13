return {
  {
    "telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>fP",
        function()
          -- require("fzf-lua").files({
          --   cwd = require("lazy.core.config").options.root,
          -- })
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      {
        ";f",
        function()
          -- require("fzf-lua").files()
          require("telescope.builtin").find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Find Files(cwd)",
      },
      {
        ";r",
        function()
          -- require("fzf-lua").oldfiles()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Recent Files",
      },
      {
        ";g",
        function()
          -- require("fzf-lua").live_grep()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep(cwd)",
      },
      {
        "\\\\",
        function()
          -- require("fzf-lua").buffers()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        ";t",
        function()
          -- require("fzf-lua").helptags()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help Pages",
      },
      {
        ";;",
        function()
          -- require("fzf-lua").resume()
          require("telescope.builtin").resume()
        end,
        desc = "Last Float Window",
      },
      {
        ";e",
        function()
          -- require("fzf-lua").diagnostics_workspace()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Workspace Diagnostics",
      },
      {
        ";s",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "Treesitter Symbols",
      },
      {
        "sf",
        function()
          local telescope = require("telescope")
          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "File Browser",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", { opts.defaults }, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })

      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }

      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netw and use telescope-file-browser in its place
          hijack_netw = true,
          mappings = {
            ["n"] = {
              -- your custom normal mode mappings here
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "," },
        },
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      {
        "\\w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
        desc = "Spider-w",
      },
      {
        "\\e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
        desc = "Spider-e",
      },
      {
        "\\b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
        desc = "Spider-b",
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
      "nvim-telescope/telescope.nvim",
    },
    lazy = true,
    event = "BufEnter *.py", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    branch = "regexp", -- This is the regexp branch, use this for the new version
    opts = {
      settings = {
        options = {
          enable_default_searches = true,
          enabled_cached_venvs = true,
          show_telescope_search_type = true,
          notify_user_on_venv_activation = true,
          set_environment_variables = true,
        },
        search = {
          anaconda_base = {
            command = "fd /python$ /opt/anaconda3/bin --full-path --color never -E /proc",
            type = "anaconda",
          },
          anaconda_envs = {
            command = "fd /python$ /opt/anaconda3/envs --full-path --color never -E /proc",
            type = "anaconda",
          },
          cwd = {
            command = "fd '/bin/python$' $CWD --full-path --color never -E /proc -I -a -L",
          },
          python = {
            command = "fd /python3$ /bin -p --color never -d 1",
          },
        },
      },
    },
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Venv" },
    },
  },
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    },
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
}
