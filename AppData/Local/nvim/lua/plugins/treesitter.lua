return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
      },
      -- servers = {
      --   -- Ensure mason installs the server
      --   omnisharp = {},
      -- },
      ensure_installed = {
        "c",
        "c_sharp",
        "css",
        "vimdoc",
        "jsonc",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "rust",
        -- "powershell",
        "todotxt",
        "cmake",
      },

      -- configure omnisharp to fix the semantic tokens bug (really annoying)
      setup = {
        omnisharp = function(_, _)
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "omnisharp" then
              ---@type string[]
              local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
              for i, v in ipairs(tokenModifiers) do
                tokenModifiers[i] = v:gsub(" ", "_")
              end
              ---@type string[]
              local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
              for i, v in ipairs(tokenTypes) do
                tokenTypes[i] = v:gsub(" ", "_")
              end
            end
          end)
          return false
        end,
      },
    },
  },
}
