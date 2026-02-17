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
    opts = {
      ensure_installed = ts_langs,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    },
init = function()
      -- Your workaround can live here instead
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ts_langs,
callback = function(ev)
  vim.defer_fn(function()
    local ok = pcall(vim.treesitter.get_parser, ev.buf)
    if ok then
      vim.bo[ev.buf].syntax = "off"
    end
  end, 0)
        end,
      })
    end,
--    config = function(_, opts)
--      require("nvim-treesitter.configs").setup(opts)
--      -- Workaround: legacy syntax overrides Treesitter in some setups.
--      -- Disable it so Treesitter is the sole highlighter.
--      vim.api.nvim_create_autocmd("FileType", {
--        pattern = ts_langs,
--        callback = function(ev)
--          vim.defer_fn(function()
--            local ok, parsers = pcall(require, "nvim-treesitter.parsers")
--            if ok and parsers.has_parser(ev.match) then
--              vim.bo[ev.buf].syntax = "off"
--            end
--          end, 0)
--        end,
--      })
--    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
}
