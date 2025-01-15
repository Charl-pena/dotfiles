local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Mover lineas con alt
keymap("n", "<A-j>", ":m .-2<CR>==", opts)
keymap("n", "<A-k>", ":m .+1<CR>==", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Abrir errores

keymap('n', '<Leader>e', ":lua vim.diagnostic.open_float()<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Mover lineas con alt
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Gitsigns
keymap("n", "<c-x>", "<cmd>Gitsigns preview_hunk<cr>", opts)

-- NvimTree
-- keymap("n", "<c-n>", ":NvimTreeToggle<cr>", opts)

-- Neo-tree
keymap("n", "<c-n>", ":Neotree toggle<cr>", opts)

-- Prettier --
-- Formatear el archivo actual
-- keymap("n", "<leader>ñ", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
keymap("n", "<leader>ñ", "<cmd>lua if not pcall(vim.lsp.buf.format, { async = true }) then print('Error al formatear') end<CR>", opts)

-- ToggleTerm --
-- Abrir lazygit 
keymap("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
