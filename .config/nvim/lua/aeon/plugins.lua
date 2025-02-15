local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Colorschemes
  use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
  use "xiyaowong/transparent.nvim"

  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used by lots of plugins
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,                      -- Se enlaza automáticamente al LSP
        hint_enable = true,               -- Activa la sugerencia en línea (signature hint)
        handler_opts = {
          border = "rounded"              -- Opcional: bordes redondeados en la ventanita
        },
        extra_trigger_chars = { "(", "," }, -- Caracteres que disparan el signature help
        toggle_key = "<M-x>"              -- Tecla para activar/desactivar el plugin (opcional)
      })
    end
  }
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "NvChad/nvim-colorizer.lua"
  use 'famiu/bufdelete.nvim'
  use "nvim-tree/nvim-web-devicons"
  use "windwp/nvim-autopairs"
  use "akinsho/bufferline.nvim"
  -- use "nvim-tree/nvim-tree.lua"
  use "akinsho/toggleterm.nvim"
  use "goolord/alpha-nvim"
  use "lewis6991/gitsigns.nvim"
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
  use { 'nvimtools/none-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- opcional, pero recomendado
      "MunifTanjim/nui.nvim",
    }
  }
  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use 'hrsh7th/cmp-nvim-lsp'     -- Fuente de autocompletado para LSP (Language Server Protocol)
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
