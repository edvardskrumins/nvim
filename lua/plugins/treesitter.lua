return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      -- Core
      "lua",
      "vim",
      "vimdoc",

      -- PHP / Laravel
      "php",
      "phpdoc",

      -- FE 
      "javascript",
      "typescript",
      "tsx",
      "json",

      -- Deploy 
      "dockerfile",
      "yaml",

      -- General
      "html",
      "css",
      "bash",
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false 
    },

    indent = {
      enable = true,
    },

    autotag = {
      enable = true,
    },
  },
}
