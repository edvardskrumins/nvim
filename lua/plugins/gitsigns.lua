return -- lazy.nvim
{
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                vim.keymap.set("n", "<leader>hp", gs.preview_hunk,  { buffer = bufnr, desc = "Preview hunk" })
                vim.keymap.set("n", "<leader>hr", gs.reset_hunk,    { buffer = bufnr, desc = "Reset hunk" })
                vim.keymap.set("n", "]h",         gs.next_hunk,     { buffer = bufnr, desc = "Next hunk" })
                vim.keymap.set("n", "[h",         gs.prev_hunk,     { buffer = bufnr, desc = "Prev hunk" })
            end,
        })
    end
}
