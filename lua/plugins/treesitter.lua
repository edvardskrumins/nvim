local ts_langs = {
  "go", "gomod", "gowork", "php", "phpdoc", "lua", "vim", "vimdoc",
  "javascript", "typescript", "tsx", "json", "dockerfile", "yaml",
  "html", "css", "bash",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter",
    opts = {
      parser_install_dir = vim.fn.stdpath("data") .. "/site",
      ensure_installed = ts_langs,
      indent = { enable = true },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
}
