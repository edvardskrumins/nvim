return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<CR>",          desc = "Diff view (all changes)" },
        { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
        { "<leader>gx", "<cmd>DiffviewClose<CR>",         desc = "Close diff view" },
    },
    opts = {
        enhanced_diff_hl = true,
        view = {
            default = {
                layout = "diff2_horizontal",
            },
        },
        file_panel = {
            listing_style = "tree",
            win_config = {
                position = "left",
                width = 35,
            },
        },
        keymaps = {
            file_panel = {
                { "n", "r", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file panel" } },
            },
        },
    },
}
