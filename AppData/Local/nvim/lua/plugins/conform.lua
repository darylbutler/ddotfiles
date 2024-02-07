return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        css = { "prettier" },
        -- cs = { "csharpier" },
      },

      -- formatters = {
      --   csharp = {
      --     command = "dotnet-csharpier",
      --     args = { "--write-stdout" },
      --     stdin = true,
      --   },
      -- },
    },
  },
}
