return {
    "stevearc/conform.nvim",
    config = function()
        local gopath = vim.fn.system("go env GOPATH"):gsub("%s+", "")
        vim.env.PATH = vim.env.PATH .. ":" .. gopath .. "/bin"

        require("conform").setup({
            formatters_by_ft = {
                php = { "pint" },
                go = { "goimports" },
            },
            formatters = {
                pint = {
                    args = { "--config", vim.fn.expand("~/.config/nvim/pint.json"), "$FILENAME" },
                },
            },
        })

        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ lsp_fallback = false })
        end, { noremap = true, silent = true })
    end,
}
