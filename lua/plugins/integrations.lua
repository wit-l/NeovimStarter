return {
  --   {
  --     "vhyrro/luarocks.nvim",
  --     priority = 1000,
  --     config = true,
  --     lazy = true,
  --     opts = {
  --       rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
  --     },
  --   },
  --   {
  --     "rest-nvim/rest.nvim",
  --     lazy = true,
  --     ft = "http",
  --     event = "BufEnter *.http",
  --     dependencies = { "luarocks.nvim" },
  --     keys = {
  --       {
  --         "\\r",
  --         "<cmd>Rest run<cr>",
  --         desc = "Test the current file",
  --       },
  --     },
  --   },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      {
        "\\s",
        function()
          require("kulala").run()
        end,
        mode = { "n", "v" },
        desc = "Send request",
        ft = { "http", "rest" },
      },
      {
        "\\a",
        function()
          require("kulala").run_all()
        end,
        mode = { "n", "v" },
        desc = "Send all requests",
        ft = "http",
      },
      {
        "<leader>Ra",
        function()
          require("kulala").run_all()
        end,
        desc = "Send all requests",
        ft = { "http", "rest" },
      },
      {
        "<leader>Ro",
        function()
          require("kulala").open()
        end,
        desc = "Open kulala",
        ft = { "http", "rest" },
      },
    },
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
    },
  },
}
