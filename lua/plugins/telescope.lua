return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {},
            },
            pickers = {
                find_files = {
                    no_ignore = true,
                    hidden = true,
                },
                live_grep = {
                    additional_args = { "--no-ignore" },
                },
            },
        })
        local grep_excludes = {
            "--glob", "!**/node_modules/*",
            "--glob", "!**/vendor/*",
        }
        require("telescope").load_extension("ui-select")
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff',
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--no-ignore-vcs', '-g', '!.git', '-g', '!**/node_modules/*', '-g', '!**/vendor/*' }})<cr>",
            { desc = 'Telescope find files (excludes node_modules, vendor)' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
        vim.keymap.set('n', '<leader>fg', function()
            builtin.live_grep({
                additional_args = vim.list_extend({ "--no-ignore" }, grep_excludes),
            })
        end, { desc = 'Telescope live grep (excludes node_modules, vendor)' })
        vim.keymap.set('n', '<leader>fG', function()
            builtin.live_grep({ additional_args = { "--no-ignore" } })
        end, { desc = 'Telescope live grep (include node_modules, vendor)' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

        vim.keymap.set('n', '<leader>fw', builtin.grep_string, {
            desc = 'Search word under cursor'
        })


        vim.keymap.set('v', '<leader>fg', function()
            -- yank visual selection
            vim.cmd('normal! "vy')

            require('telescope.builtin').grep_string({
                search = vim.fn.getreg('v'),
            })
        end, { desc = 'Search visual selection in project' })
    end
}
