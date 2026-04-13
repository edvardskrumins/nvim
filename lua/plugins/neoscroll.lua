return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({
      mappings = {
        "<C-u>", "<C-d>",
        "<C-b>", "<C-f>",
        "<C-y>",
     --  "<C-e>",
        "zt", "zz", "zb",
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.0,
      easing = "linear",
      performance_mode = false,
      ignored_events = {
        "WinScrolled",
        "CursorMoved",
      },
    })
    local neoscroll = require("neoscroll")
    vim.keymap.set({'n','v','x'}, '<C-k>', function() neoscroll.scroll(-0.10, { move_cursor=false, duration=100 }) end)
    vim.keymap.set({'n','v','x'}, '<C-j>', function() neoscroll.scroll( 0.10, { move_cursor=false, duration=100 }) end)
  end,
}
