vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"


-- Peachpuff with black background 
-- vim.opt.background = "dark"
--vim.cmd("colorscheme peachpuff")




--vim.api.nvim_create_autocmd("ColorScheme", {
--  pattern = "cobalt2",
--  callback = function()
--    vim.api.nvim_set_hl(0, "Cursor", { fg = "#0E354B", bg = "#ffffff" })
--  end,
--})




-- Indentation: 4 spaces per level, insert spaces instead of tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

