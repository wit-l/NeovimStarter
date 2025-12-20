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
          require("fzf-lua").files({
            cwd = require("lazy.core.config").options.root,
          })
          -- require("telescope.builtin").find_files({
          --   cwd = require("lazy.core.config").options.root,
          -- })
        end,
        desc = "Find Plugin File",
      },
      {
        ".f",
        function()
          require("fzf-lua").files()
          -- require("telescope.builtin").find_files({
          --   no_ignore = false,
          --   hidden = true,
          -- })
        end,
        desc = "Find Files(cwd)",
      },
      {
        ".r",
        function()
          require("fzf-lua").oldfiles()
          -- require("telescope.builtin").oldfiles()
        end,
        desc = "Recent Files",
      },
      {
        ".g",
        function()
          require("fzf-lua").live_grep()
          -- require("telescope.builtin").live_grep()
        end,
        desc = "Grep(cwd)",
      },
      {
        ".b",
        function()
          require("fzf-lua").buffers()
          -- require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        ".t",
        function()
          require("fzf-lua").helptags()
          -- require("telescope.builtin").help_tags()
        end,
        desc = "Help Pages",
      },
      {
        ".;",
        function()
          require("fzf-lua").resume()
          -- require("telescope.builtin").resume()
        end,
        desc = "Last Float Window",
      },
      {
        ".d",
        function()
          require("fzf-lua").diagnostics_workspace()
          -- require("telescope.builtin").diagnostics()
        end,
        desc = "Workspace Diagnostics",
      },
      {
        ".s",
        function()
          require("fzf-lua").treesitter()
          -- require("telescope.builtin").treesitter()
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
      local fb_actions = telescope.extensions.file_browser.actions

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
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
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
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
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
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      search = {
        miniconda_envs = {
          command = "$FD python.exe$ " .. os.getenv("MINIFORGE") .. "/envs --no-ignore-vcs --full-path -a -E Lib",
          type = "anaconda",
        },
        miniconda_base = {
          command = "$FD miniforge3//python.exe$ "
            .. os.getenv("MINIFORGE")
            .. " --no-ignore-vcs --full-path -a --color never",
          type = "anaconda",
        },
        cwd = {
          command = "$FD '/bin/python$' $CWD --full-path --color never -a -L -E /proc -E .git/ -E .wine/ -E .steam/ -E Steam/ -E site-packages/",
        },
      },
    },
  },
}
