return {
  {
    "folke/neodev.nvim",
    opts = {
      experimental = {
        pathStrict = true,
      },
      library = {
        plugins = { "neotest" },
        types = true,
      },
    },
  },
}
