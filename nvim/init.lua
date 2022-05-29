----------------------------------------
-- Section Packer
----------------------------------------
-- need to be aligned with the installation path of packer
vim.opt.packpath:append(vim.fn.stdpath("config") .. "/site")

-- impatient need to be placed at the very top
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

local fn = vim.fn
local install_path = fn.stdpath('config')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print "Installing packer close and reopen neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
status_ok, packer = pcall(require, 'packer')
if not status_ok then
  error("Packer not successfully loaded!")
  return
end

local plugins = {
  {'lewis6991/impatient.nvim'},
  -- Packer can manage itself
  {'wbthomason/packer.nvim'},

  -- utils function api
  {'nvim-lua/plenary.nvim'},
  {'nvim-lua/popup.nvim'},

  -- LSP support
  {'williamboman/nvim-lsp-installer'},
  { 'neovim/nvim-lspconfig'},
  {'onsails/lspkind-nvim'},
  {'stevearc/aerial.nvim'},
  {'folke/trouble.nvim'},
  {'RRethy/vim-illuminate'},
  {'ray-x/lsp_signature.nvim'},

  -- completion
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-calc'},
  {'hrsh7th/cmp-nvim-lua'},
  {'dcampos/cmp-snippy'},
  {"L3MON4D3/LuaSnip"},
  {"saadparwaiz1/cmp_luasnip"},
  {"rafamadriz/friendly-snippets"},

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'romgrk/nvim-treesitter-context'},
  {'nvim-treesitter/nvim-treesitter-refactor'},

  -- Fuzzy finder
  { 'nvim-telescope/telescope.nvim' },
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

  -- UI
  {"mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim"},
  {'olimorris/onedarkpro.nvim'},
  {'kyazdani42/nvim-web-devicons'},
  {'nvim-lualine/lualine.nvim'},
  {'kyazdani42/nvim-tree.lua'},
  { 'romgrk/barbar.nvim' },
  {'lukas-reineke/indent-blankline.nvim', },
  { "mcchrish/nnn.vim", },

  -- Edit
  { 'numToStr/Comment.nvim', },
  {'windwp/nvim-autopairs'},
  {'machakann/vim-sandwich'},
  -- {'wellle/targets.vim', enable = false},

  -- work_flow
  {"akinsho/toggleterm.nvim", },
  { 'lewis6991/gitsigns.nvim', },
  { "aserowy/tmux.nvim", },
  {'sakhnik/nvim-gdb', run = './install.sh' },
  {'sudormrfbin/cheatsheet.nvim'},
  {'ldelossa/litee.nvim'},
  {'ldelossa/litee-calltree.nvim'},

  -- utility
  {'folke/which-key.nvim', },
  { 'rmagatti/auto-session', },
  {'winston0410/cmd-parser.nvim'},
  {'winston0410/range-highlight.nvim', },
  {'mbbill/undotree'},
  {'monaqa/dial.nvim'},
  {'norcalli/nvim-colorizer.lua', },
  {'xiyaowong/accelerated-jk.nvim'},
  { "folke/todo-comments.nvim"},
  {'edluffy/specs.nvim'},
  {'rhysd/conflict-marker.vim'},
}

packer.init {
  package_root = vim.fn.stdpath('config')..'/site'..'/pack',
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
    prompt_border = "single",
  },
  auto_clean = true,
  profile = {
    enable = true,
    threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  }
}

packer.reset()
packer.startup(function(use)
  for _, v in pairs(plugins) do
    use(v)
  end
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

----------------------------------------
-- Load modules
----------------------------------------
vim.cmd("source ~/.config/nvim/plugin/packer_compiled.lua")
-- print(vim.inspect(packer_plugins))
require("options")
require("plugins")
require("mappings")
require("autocmds")
