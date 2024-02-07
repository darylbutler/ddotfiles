return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Omnisharp/omnisharp-roslyn",
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<leader>cf", false }
    end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        jsonls = {
          mason = false,
        },
        -- omnisharp = {
        --   cmd = { "dotnet", "/Users/butleda5/scoop/apps/omnisharp-net6/current/OmniSharp.dll" },
        --   enable_roslyn_analyzers = true,
        --   organize_imports_on_format = true,
        --   enable_import_completion = true,
        -- },
      },
    },
  },
}
