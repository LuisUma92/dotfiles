return{
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    -- lazy = true,
    -- config = function()
    --   -- Disable automatic setup, we are doing it manually
    --   vim.g.lsp_zero_extend_cmp = 0
    --   vim.g.lsp_zero_extend_lspconfig = 0
    -- end,
  },
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-nvim-lsp-signature-help"},
  -- {"hrsh7th/cmp-buffer"},
  -- {"hrsh7th/cmp-path"},
  -- {"saadparwaiz1/cmp_luasnip"},
  -- {"hrsh7th/cmp-nvim-lua"},
  -- {"rafamadriz/friendly-snippets"},
  {"HallerPatrick/py_lsp.nvim"},
  {"tweekmonster/django-plus.vim"},
  {
    'williamboman/mason.nvim',
    lazy = false,
  },
  {
    'williamboman/mason-lspconfig.nvim',
  },

  -- autoPair
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },

  -- Comment gcc
  {
    'tpope/vim-commentary'
  },
  -- Indent lines
  {
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    config = function()
        require('indentmini').setup({
            char =  '▏'
        })
    end,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    -- config = function()
    --   -- Here is where you configure the autocompletion settings.
    --   local lsp_zero = require('lsp-zero')
    --   lsp_zero.extend_cmp()

    --   -- And you can configure cmp even more, if you want to.
    --   local cmp = require('cmp')
    --   local cmp_action = lsp_zero.cmp_action()
    --   local cmp_autopair = require('nvim-autopairs.completion.cmp')

    --   cmp.event:on(
    --     'confirm_done',
    --     cmp_autopair.on_confirm_done()
    --   )

    --   cmp.setup({
    --     formatting = lsp_zero.cmp_format(),
    --     mapping = cmp.mapping.preset.insert({
    --       ['<C-Space>'] = cmp.mapping.complete(),
    --       ['<C-S-U>'] = cmp.mapping.scroll_docs(-4),
    --       ['<C-S-D>'] = cmp.mapping.scroll_docs(4),
    --       ['<C-S-F>'] = cmp_action.luasnip_jump_forward(),
    --       ['<C-S-B>'] = cmp_action.luasnip_jump_backward(),
    --     })
    --   })
    --   cmp.setup.filetype("tex",{
    --     sources = {
    --       {
    --         name = 'vimtex'
    --       }
    --     }
    --   })
    -- end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    -- config = function()
    --   -- This is where all the LSP shenanigans will live
    --   local lsp_zero = require('lsp-zero')
    --   lsp_zero.extend_lspconfig()

    --   --- if you want to know more about lsp-zero and mason.nvim
    --   --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
    --   lsp_zero.on_attach(function(client, bufnr)
    --     -- see :help lsp-zero-keybindings
    --     -- to learn the available actions
    --     lsp_zero.default_keymaps({buffer = bufnr})
    --   end)

    --   require('mason-lspconfig').setup({
    --     ensure_installed = {},
    --     handlers = {
    --       lsp_zero.default_setup,
    --       lua_ls = function()
    --         -- (Optional) Configure lua language server for neovim
    --         local lua_opts = lsp_zero.nvim_lua_ls()
    --         require('lspconfig').lua_ls.setup(lua_opts)
    --       end,
    --     }
    --   })
    -- end
  },
}
