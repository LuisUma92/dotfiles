local lsp_zero = require('lsp-zero')

local cmp_action = lsp_zero.cmp_action()
lsp_zero.extend_lspconfig()
lsp_zero.extend_cmp()

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
lsp_zero.set_sign_icons({
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»'
    })

-- LuaSnips
-- Implemented on cmp mapping
-- local ls = require("luasnip")
-- vim.keymap.set({"i"}, "<C-i>",
--   function() ls.expand() end, {silent = true}
--   )
-- vim.keymap.set({"i", "s"}, "<M-Tab>",
--   function() ls.jump( 1) end, {silent = true}
--   )
-- vim.keymap.set({"i", "s"}, "<S-Tab>",
--   function() ls.jump(-1) end, {silent = true}
--   )
-- vim.keymap.set({"i", "s"}, "<M-Tab>", function()
-- 	if ls.choice_active() then
--     s.change_choice(1)
-- 	end
-- end, {silent = true})


-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({
  icons = {
    package_installed = "✓",
    package_pending = "➜",
    package_uninstalled = "✗"
  }
})
require('mason-lspconfig').setup({
  ensure_installed = {
    'typos_lsp',
  --   'clangd',
  --   'eslint',
  --   'html',
  --   'jsonls',
    'texlab',
  --   'marksman',
    'pyright',
    'pylsp',
  --   'sqlls',
  --   'lemminx',
    'yamlls',
  --   'tsserver',
  --   'rust_analyzer'
    },
  automatic_installation = true,
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

local cmp_autopair = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopair.on_confirm_done()
)

cmp.setup({
  sources = {
    -- {name = 'path'},
    {name = 'nvim_lsp'},
    -- {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'vimtex'},
    {name = 'nvim_lsp_signature_help'}
    -- {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<S-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<M-Tab>'] = cmp_action.luasnip_jump_forward(),
    ['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
    ['<C-i>'] = cmp_action.luasnip_supertab(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<M-f>'] = cmp_action.luasnip_jump_forward(),
    ['<M-b>'] = cmp_action.luasnip_jump_backward(),
    ['<M-u>'] = cmp.mapping.scroll_docs(-4),
    ['<M-d>'] = cmp.mapping.scroll_docs(4),
  }),
})

-- Snippets inporting
-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})
-- require("luis.snips.tex")
-- require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/lua/luis/snippets"})


-- require("py_lsp").setup({
--   host_python = "/usr/bin/python3",
--   default_venv_name = ".venv",
--   -- language_server = "pylsp",
--   language_server = "lsp-zero",
--   source_strategies = {"poetry", "default", "system"},
--   -- capabilities = capabilities,
--   -- on_attach = on_attach,
--   pylsp_plugins = {
--       autopep8 = {
--           enabled = true
--       },
--       pyls_mypy = {
--           enabled = true
--       },
--       pyls_isort = {
--           enabled = true
--       },
--       flake8 = {
--           enabled = true,
--           executable = ".venv/bin/flake8",
--       },
--   },
-- })
