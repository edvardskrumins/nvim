return {
  "windwp/nvim-autopairs",
  dependencies = "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({})

    -- Integrate with cmp: avoid inserting duplicate closing chars on completion
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
