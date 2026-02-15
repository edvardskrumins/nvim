return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        adaptive_size = true,
      },
      actions = {
        open_file = {
          stay_in_tree = true, -- don't jump focus to the editor when opening
        },
      },
    })
  end,
}
