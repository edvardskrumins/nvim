require('config.options')
require('config.keybinds')
require('config.plugins')

require("lazy").setup({
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"}
})

