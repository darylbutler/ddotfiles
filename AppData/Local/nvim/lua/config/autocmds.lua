-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Colorcolumn by filetype
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Settings_Per_Filetype", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neo-tree",
    "alpha",
  },
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})
