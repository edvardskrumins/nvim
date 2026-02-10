vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true


-- Peachpuff with black background 
vim.opt.background = "dark"
vim.cmd("colorscheme peachpuff")

local function peachpuff_black_bg()
  local black = "#000000"
  local dim = "#0d0d0d"
  local accent = "#8f9348"  -- keywords + line numbers
  vim.api.nvim_set_hl(0, "Normal", { bg = black })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = black })
  vim.api.nvim_set_hl(0, "NonText", { bg = black })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = black })
  vim.api.nvim_set_hl(0, "LineNr", { bg = black, fg = accent })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = black, fg = accent })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = black })
  vim.api.nvim_set_hl(0, "VertSplit", { bg = black })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = black })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = black })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = black })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = dim })
  -- Comments + PHPDoc @tags: force olive 
  vim.api.nvim_set_hl(0, "Comment", { fg = accent, ctermfg = 3 })
  vim.cmd("highlight! Comment guifg=" .. accent .. " ctermfg=3")
  -- Keywords (for, in, if, else, etc.) + line numbers
  vim.api.nvim_set_hl(0, "Statement", { fg = accent })
  vim.api.nvim_set_hl(0, "Conditional", { fg = accent })
  vim.api.nvim_set_hl(0, "Repeat", { fg = accent })
  vim.api.nvim_set_hl(0, "Operator", { fg = accent })
  vim.api.nvim_set_hl(0, "Keyword", { fg = accent })
  -- PHP: namespace, class, extends, public, type hints, ->, variables: olive (accent)
  vim.api.nvim_set_hl(0, "phpStructure", { link = "String" })
  vim.api.nvim_set_hl(0, "phpStorageClass", { link = "String" })
  -- vim.api.nvim_set_hl(0, "phpDefine", { fg = accent })
  vim.api.nvim_set_hl(0, "phpType", { link = "String" })
  -- vim.api.nvim_set_hl(0, "phpOperator", { fg = accent })
  vim.api.nvim_set_hl(0, "phpMemberSelector", { fg = accent })  -- -> and ::
  -- vim.api.nvim_set_hl(0, "phpVarSelector", { fg = accent })
  -- vim.api.nvim_set_hl(0, "phpIdentifier", { fg = accent })
  -- vim.api.nvim_set_hl(0, "@operator", { fg = accent })
  -- PHP docblock tags: @mixin, @param, @return, etc. (legacy + treesitter)
  vim.api.nvim_set_hl(0, "phpDocTags", { fg = accent })
  vim.api.nvim_set_hl(0, "@attribute", { fg = accent })  -- Treesitter: @mixin, @param, etc.
end
peachpuff_black_bg()


-- Indentation: 4 spaces per level, insert spaces instead of tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

