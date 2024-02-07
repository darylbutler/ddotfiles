return {
  {
    dir = "~\\AppData\\Local\\nvim\\local_plugins\\dracula_pro",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.dracula_colorterm = 1
      vim.g.dracula_bold = 1
      vim.g.dracula_italic = 1
      vim.g.dracula_underline = 1
      vim.g.dracula_undercurl = 1
      -- vim.g.dracula_
    end,
  },
  {
    "srcery-colors/srcery-vim",
    lazy = false,
    priority = 1000,
  },
  -- {
  --   "gruvbox-community/gruvbox",
  --   lazxy = false,
  --   priority = 1000,
  -- },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = "hard",
      dim_inactive = true,
      invert_intend_guides = true,
      overrides = {
        IlluminatedWordText = { bg = "#4d520d", bold = true },
        IlluminatedWordRead = { bg = "#4d520d", bold = true },
        IlluminatedWordWrite = { bg = "#431313", bold = true },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },

      background = { -- map the value of 'background' option to a theme
        dark = "dragon",
        light = "lotus",
      },
    },
  },
  -- { "sainnhe/gruvbox-material" },
  -- { "elianiva/gruvy.nvim" },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    proirity = 1000,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvy",
      -- colorscheme = "gruvbox",
      colorscheme = "dracula_pro_van_helsing",
      -- colorscheme = "srcery",
      -- colorscheme = "kanagawa",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "ayu",
    },
  },
}
