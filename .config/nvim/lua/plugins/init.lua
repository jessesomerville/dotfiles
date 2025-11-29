return {
  -- Color scheme
  -- {
  --   "vague-theme/vague.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require "config.vague"
  --   end,
  -- },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = {
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = false },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,          -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
          theme = { 
            all = { ui = { bg_gutter = "none" } }
          },
      },
      overrides = function(colors) -- add/modify highlights
          return {}
      end,
      theme = "wave"
    },
  },
  
  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      return require "config.nvim-tree"
    end,
  },

  -- Tab bar
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require "config.bufferline"
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "config.go"
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Setup Mason to automatically install gopls
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls" },
      })

      -- 2. Define standard capabilities for autocompletion
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
    end,
  },

  -- Autocompletion Engine (Same as before)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        })
      })
    end,
  }
}
