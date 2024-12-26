vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 3
vim.opt.tabstop = 3
vim.opt.cursorline = true
vim.opt.cmdheight = 1
vim.opt.number = true
vim.opt.list = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 2
vim.opt.wrap = false
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.guifont = "JetBrainsMono Nerd Font:h18"

vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'DiffDelete' })

-- remove the "How-to disable mouse"
vim.cmd.aunmenu("PopUp.How-to\\ disable\\ mouse")
vim.cmd.aunmenu("PopUp.-1-")

-- don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '',
    command = 'set fo-=c fo-=r fo-=o'
})
