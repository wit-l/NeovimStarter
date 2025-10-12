return {
  {
    "gitsang/qwen-code.nvim",
    cmd = "Qwen",
    -- Example key mappings for common actions:
    keys = {
      { "<leader>a/", "<cmd>Qwen toggle<cr>", desc = "Toggle Qwen CLI" },
      { "<leader>aa", "<cmd>Qwen ask<cr>", desc = "Ask Qwen", mode = { "n", "v" } },
      { "<leader>af", "<cmd>Qwen add_file<cr>", desc = "Add File" },
    },
    dependencies = {
      "folke/snacks.nvim",
    },
    config = true,
  },
}
