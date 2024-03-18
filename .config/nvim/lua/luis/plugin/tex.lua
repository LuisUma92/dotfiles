return {
    {
      "lervag/vimtex",
      lazy = false,
      config = function()
   	    vim.g.tex_flavor = 'latex'
        vim.g.vimtex_view_method='zathura'
       	--vim.g.vimtex_view_general_viewer = "okular"
        --vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
   	    -- vim.g.vimtex_view_general_viewer = "evince"
   	    vim.g.vimtex_quickfix_mode = 0
   	    vim.g.vimtex_compiler_latexmk_engines = {_ = "-xelatex"}
   	    vim.g.tex_indent_items = 0
   	    vim.g.tex_indent_brace = 0
   	    vim.g.tex_indent_and = 0
      end
    },
    --{
    --    'KeitaNakamura/tex-conceal.vim',
    --    config = function ()
    --        vim.opt.conceallevel = 1
    --        vim.g.tex_conceal = 'abdmg'
    --        --vim.cmd = [[hi Conceal ctermbg=none]]
    --    end
    --},
<<<<<<< HEAD
    { 'saadparwaiz1/cmp_luasnip' },
=======
>>>>>>> 344530c (430FM old)
    {
	    "L3MON4D3/LuaSnip",
	    -- follow latest release.
	    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	    -- install jsregexp (optional!).
	    build = "make install_jsregexp"
    },
    {
      "iurimateus/luasnip-latex-snippets.nvim",
      -- vimtex isn't required if using treesitter
      dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
      config = function()
<<<<<<< HEAD
        require'luasnip-latex-snippets'.setup({ use_treesitter = true })
=======
        require'luasnip-latex-snippets'.setup()
        -- or setup({ use_treesitter = true })
>>>>>>> 344530c (430FM old)
        require("luasnip").config.setup { enable_autosnippets = true }
        allow_on_markdown = true -- whether to add snippets to markdown filetype
      end,
    },
    {
      "micangl/cmp-vimtex",
      -- config = {
      --   sources = {
      --     { name = 'vimtex', },
      --   },
      -- }
    },
	--{"honza/vim-snippets"},
}
