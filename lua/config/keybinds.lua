vim.g.mapleader = ' '                         -- this maps the leader key to the spacebar
vim.keymap.set('n', '<leader>cd', vim.cmd.Ex) -- "n" here applies the mapping in normal mode, "<leader>cd" is the key combination and "vim.cmd.Ex" open the file explorer
vim.keymap.set("v", "p", '"_dP')              -- delete and paste


vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })


vim.keymap.set("n", "l", function()
    vim.cmd("normal! l")
end, { noremap = true, silent = true })


vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action) -- import class

-- Splits
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>sc', '<C-w>c', { desc = 'Close split' })
vim.keymap.set('n', '<leader>so', '<C-w>o', { desc = 'Close all other splits' })
