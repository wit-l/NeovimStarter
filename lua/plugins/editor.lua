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
