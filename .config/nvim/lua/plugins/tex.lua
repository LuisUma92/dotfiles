return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
      -- disable `K` as it conflicts with LSP hove
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      --vim.g.vimtex_view_general_viewer = "okular"
      --vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      -- vim.g.vimtex_view_general_viewer = "evince"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-lualatex",
        pdfdvi = "-pdfdvi",
        pdfps = "-pdfps",
        pdflatex = "-pdf",
        luatex = "-lualatex",
        lualatex = "-lualatex --shell-escape",
        xelatex = "-xelatex",
      }
      -- vim.g.vimtex_compiler_latexmk = {
      --   aux_dir = 'TexAuxDir',
      --   out_dir = '',
      --   callback = 1,
      --   continuous = 1,
      --   executable = 'latexmk',
      --   hooks = {},
      --   options = {
      --     '-verbose',
      --     '-file-line-error',
      --     '-synctex=1',
      --     '-interaction=nonstopmode',
      --   },
      -- }
      vim.g.vimtex_syntax_conceal_disable = true
      vim.g.vimtex_toc_config = {
        split_pos = ":vert :botright",
        split_width = 50,
      }
      vim.g.tex_indent_items = 0
      vim.g.tex_indent_brace = 0
      vim.g.tex_indent_and = 0
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
    },
  },
}
