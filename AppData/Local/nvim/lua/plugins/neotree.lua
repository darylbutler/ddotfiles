return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        if vim.bo.filetype == "neo-tree" then
          require("neo-tree.command").execute({ action = "close" })
        else
          require("neo-tree.command").execute({ action = "focus", dir = require("lazyvim.util").root.get() })
        end
      end,
    },
  },
}
