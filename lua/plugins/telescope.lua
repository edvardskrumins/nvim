return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
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
