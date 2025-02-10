-- SOURCE VIMRC
-- SOURCE VIMRC
-- SOURCE VIMRC

-- vim.cmd([[
--     set runtimepath^=~/.vim runtimepath+=~/.vim/after
--     let &packpath = &runtimepath
--     source ~/.vimrc
-- ]])

-- SOURCE VIMRC END
-- SOURCE VIMRC END
-- SOURCE VIMRC END

vim.opt.clipboard = "unnamed"
-- vim.opt.colorcolumn = 80
vim.opt.autoindent = true  -- Enable automatic indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Automatically indent new lines
vim.opt.shiftwidth = 4     -- Number of spaces used for each indentation step
vim.opt.softtabstop = 4
vim.opt.tabstop = 4        -- number of spaces a tab counts for
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 250

-- vim.api.hi
-- vim.highlight "colorcolumn"
-- ctermbg = 7
-- guibg = #898989

-- vim.hl.ColorColumn ctermbg=7 guibg=#898989
-- vim.hl.ColorColumn({ ctermbg = "7", guibg = "#898989" })
-- "hl-ColorColumn"
-- autocmd WinLeave * set colorcolumn=0
-- autocmd WinEnter * set colorcolumn=+0
