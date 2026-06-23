return {
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
    enabled = false,
    branch = "master",
  },
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      search = {
        miniconda_envs = {
          command = "$FD 'bin/python$' ~/.config/conda/envs --no-ignore-vcs --full-path --color never",
          type = "anaconda",
        },
        miniconda_base = {
          command = "$FD '/python$' /opt/miniforge/bin --no-ignore-vcs --full-path --color never",
          type = "anaconda",
        },
      },
    },
  },
}
