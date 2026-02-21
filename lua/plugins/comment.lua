return {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup()
    vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { noremap = true, silent = true })
  end,
}
