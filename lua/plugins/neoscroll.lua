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
    require("neoscroll.config").set_mappings({
      ["<C-k>"] = { "scroll", { "-0.10", "false", "100" } },
      ["<C-j>"] = { "scroll", {  "0.10", "false", "100" } },
    })
  end,
}
