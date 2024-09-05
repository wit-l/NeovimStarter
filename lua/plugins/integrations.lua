return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      vim.g.rest_nvim = {}
    end,
    keys = {
      {
        "\\r",
        "<cmd>Rest run<cr>",
        desc = "Test the current file",
      },
    },
  },
}
