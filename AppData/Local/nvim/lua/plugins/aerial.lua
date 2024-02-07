return {
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Aerial Symbols Window" },
      { "<leader>O", "<cmd>AerialNavToggle<CR>", desc = "Aerial Symbols Navigation Window" },
    },
    init = function()
      require("lazyvim.util").on_attach = function(_, buf)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "<leader>{", "<cmd>AerialPrev<CR>", { buffer = buf })
        vim.keymap.set("n", "<leader>}", "<cmd>AerialNext<CR>", { buffer = buf })
      end
    end,
  },
}
