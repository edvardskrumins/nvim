return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto", component_separators = "|", section_separators = { left = "", right = "" } },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    },
  },
}
