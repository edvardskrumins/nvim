return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "moon",
      disable_background = true, -- transparent, lets tmux bg show through
      disable_float_background = true,
      disable_italics = true, -- optional, Primeagen often disables italics
    })
    vim.cmd("colorscheme rose-pine")
  end,
}
