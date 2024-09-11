return {
  {
    "vhyrro/luarocks.nvim",
    enabled = false,
    priority = 1000,
    config = true,
    lazy = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "rest-nvim/rest.nvim",
    lazy = true,
    ft = "http",
    event = "BufEnter *.http",
    dependencies = { "luarocks.nvim" },
    keys = {
      {
        "\\r",
        "<cmd>Rest run<cr>",
        desc = "Run request under the cursor",
      },
    },
  },
}
