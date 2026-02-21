return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                php = { "pint" },
            },
            formatters = {
                pint = {
                    args = { "--config", vim.fn.expand("~/.config/nvim/pint.json"), "$FILENAME" },
                },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })

        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ lsp_fallback = false })
        end, { noremap = true, silent = true })
    end,
}
