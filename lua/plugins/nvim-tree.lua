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
          quit_on_open = false,
        },
      },
      update_focused_file = {
          enable = true,
          update_root = false, -- optional
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local opts = function(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Load all default mappings first
        api.config.mappings.default_on_attach(bufnr)

        -- Override <CR> and single click to preview instead of open
        vim.keymap.set("n", "<CR>", api.node.open.preview, opts("Preview"))
        vim.keymap.set("n", "o",    api.node.open.preview, opts("Preview"))
      end,
    })
  end,
}
