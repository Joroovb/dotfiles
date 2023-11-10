-- Plugins
local fn = vim.fn;
local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim";

if not vim.loop.fs_stat(install_path) then
  vim.notify('Installing Plugins... please wait!')

  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  });
end
vim.opt.rtp:prepend(install_path);

require('lazy').setup({
  -- Color schemes
  'blazkowolf/gruber-darker.nvim',

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  -- Search & replace visual selection using CTRL+f
  {
    'windwp/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('spectre').setup({
        color_devicons = true,
        open_cmd = '50vsplit new',
        vim.keymap.set('v', '<C-f>', function()
          require('spectre').open_visual({ select_word = true })
        end)
      })
    end
  },

  -- Visualise and control undo history in tree form.
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { ',r', '<CMD>UndotreeToggle<CR>', desc = 'Undotree', noremap = true },
    },
  },

  -- Comment/Uncomment blocks of code using gc
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        ignore = '^$',
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      });
    end
  },

  -- Fuzzy selection for files and more, see plugin settings.
  {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end
  },

  -- TreeSitter integration
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function() require('plugins.treesitter') end,
    build = ':TSUpdate',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    }
  },

  -- DAP integration
  {
    'mfussenegger/nvim-dap',
    config = function() require('plugins.dap') end,
    dependencies = {
      'nvim-telescope/telescope-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
      { 'rcarriga/nvim-dap-ui', config = function() require('plugins.dapui') end  },
    }
  },

  -- LSP intigration
  {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  },

  -- Use LuaSnip as snippet provider
  {
    'L3MON4D3/LuaSnip',
    config = function() require('plugins.luasnip') end,
    dependencies = 'rafamadriz/friendly-snippets'
  },
  -- Completions
  {
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end,
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    }
  },
  -- Vimwiki
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/Sync/vimwiki',
          syntax = 'markdown',
          ext  = '.md',
          auto_export = 1,
          auto_header = 1,
          automatic_nested_syntaxes = 1,
          template_ext = '.html',
          template_path = '~/Sync/vimwiki/template/',
          path_html = '~/Sync/wiki_html',
          template_default = 'document',
          custom_wiki2html = '~/Sync/bin/wiki2html.sh'
        }
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
      vim.g.vimwiki_global_ext = 0
    end
  },
  -- Taskwiki
  {
    'tools-life/taskwiki',
    init = function() 
      vim.g.taskwiki_dont_fold = 1
    end
  },
  -- Telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  -- Cheat.sh
  'dbeniamine/cheat.sh-vim',

  
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function() require('colorizer').setup() end,
  -- }
});

