return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>qo", "<cmd>BufferLineCloseLeft|BufferLineCloseRight<cr>", desc = "Close all Other Buffers" },
      { "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Switch to buffer/tag 1" },
      { "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Switch to buffer/tag 2" },
      { "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Switch to buffer/tag 3" },
      { "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Switch to buffer/tag 4" },
      { "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Switch to buffer/tag 5" },
      { "<A-6>", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Switch to buffer/tag 6" },
      { "<A-7>", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Switch to buffer/tag 7" },
      { "<A-8>", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Switch to buffer/tag 8" },
      { "<A-9>", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Switch to buffer/tag 9" },
      { "<A-0>", "<cmd>BufferLineGoToBuffer 0<cr>", desc = "Switch to buffer/tag 10" },
      { "<A-`>", "<cmd>e #<cr>", desc = "Switch to last buffer/tag" },
    },
    opts = {
      options = {
        numbers = "ordinal",
        separator_style = "slant",
        show_tag_indicators = true,
        indicator = { style = "underline" },
        highlights = {
          indicator_selected = {
            sp = "#fb4934",
            bold = true,
            underdouble = true,
            underline = true,
          },
        },
      },
    },
  },
}
